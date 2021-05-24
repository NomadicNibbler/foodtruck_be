class MapFacade
  def self.get_trucks(address) # + radius
    lat_long = address_to_lat_long(address)
    formatted_lat_long = "#{lat_long[:lat]},#{lat_long[:lng]}"
    region = find_closest_region(formatted_lat_long)
    truck_data = FoodTruckService.get_schedules_by_city(region)
    trucks = make_trucks(truck_data)
    trucks_with_distances = assign_distances(trucks, formatted_lat_long)
    trucks_with_distances
  end

  def self.address_to_lat_long(address)
    redis = Redis.current
    redis_result = redis.get "address: #{address}"
    if redis_result
      require "pry"; binding.pry
      redis_result
    else
      MapService.get_coords(address)
      require "pry"; binding.pry
    end
    # Rails.cache.fetch "address: #{address}", expires_in: 1.week do
    # end
  end

  def self.find_closest_region(user_location)
    regions_with_distance = regions.each do |region|
      region_loc = "#{region.lat},#{region.long}"
      distance = get_distance(region_loc, user_location)
      region.add_distance(distance)
    end
    ordered_regions = regions_with_distance.sort_by do |region|
      region.distance
    end
    closest_region = ordered_regions[0].name.downcase
  end

  def self.make_trucks(truck_data)
    truck_data.map do |data|
      Truck.new(data[1])
    end
  end

  def self.regions
    regions = parse(FoodTruckService.get_regions)

    regions.map do |region_data|
      Region.new(region_data)
    end
  end

  def self.assign_distances(trucks, user_location)
    trucks_with_distance = []

    valid_trucks = validate_trucks(trucks)

    chunked_trucks = valid_trucks.each_slice(20).to_a
    chunked_trucks.each do |chunk|
      string = get_string(chunk)
      distance = DistanceService.get_distance(user_location, string)
      parsed_distance = distance_parser(distance)
      trucks_with_distance << append_truck_distance(chunk, parsed_distance)
    end
    trucks_with_distance.flatten
  end

  def self.distance_parser(raw_distance_data)
    if raw_distance_data[:rows].first[:elements].first[:status] == 'ZERO_RESULTS' || raw_distance_data[:rows].first[:elements].first[:status] == 'NOT_FOUND'
      return 100000
    else
      new_array = raw_distance_data[:rows].first[:elements].map do |truck_distance_data|
        truck_distance_data[:distance][:text].delete_suffix(' mi').gsub(',', '').to_f
      end

    end
  end

  def self.validate_trucks(trucks)
    trucks.reject do |truck|
      truck.lat == "no last location available" || truck.long == "no last location available" || truck.recent_data == false
    end
  end

  def self.get_string(valid_trucks)
    string = ""
    valid_trucks.each do |truck|
      string = "#{string}|#{truck.lat},#{truck.long}"
    end
    string[1..-1]
  end

  def self.append_truck_distance(truck_array, truck_distance)
    truck_array.each_with_index do |truck, index|
      truck.add_distance(truck_distance[index])
    end
  end

  def self.get_distance(truck_location, user_location, miles=false)
    # Get latitude and longitude
    lat1 = truck_location.split(',')[0].to_f
    lon1 = truck_location.split(',')[1].to_f
    lat2 = user_location.split(',')[0].to_f
    lon2 = user_location.split(',')[1].to_f

    # Calculate radial arcs for latitude and longitude
    dLat = (lat2 - lat1) * Math::PI / 180
    dLon = (lon2 - lon1) * Math::PI / 180


    a = Math.sin(dLat / 2) *
        Math.sin(dLat / 2) +
        Math.cos(lat1 * Math::PI / 180) *
        Math.cos(lat2 * Math::PI / 180) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2)

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    d = 6371 * c * (miles ? 1 / 1.6 : 1)
  end

  # def self.return_data(user)
    # user_address = "#{user.address}, #{user.city}, #{user.zipcode}"
    # x = OpenStruct.new({
      # id: nil,
      # username: user.username,
      # first_name: user.first_name,
      # last_name: user.last_name,
      # address: user.address,
      # city: user.city,
      # zipcode: user.zipcode,
      # trucks: format_truck_data(user_address)
      # })
  # end

  # def self.format_truck_data(user_address)
  #   x = get_trucks(user_address)
  #     x.map do |truck|
  #       new_hash = Hash.new
  #       new_hash[:description] = truck.description
  #       new_hash[:display] = truck.display
  #       new_hash[:distance] = truck.distance
  #       new_hash[:lat] = truck.lat
  #       new_hash[:logo] = truck.logo
  #       new_hash[:long] = truck.long
  #       new_hash[:name] = truck.name
  #       new_hash[:payment_methods] = truck.payment_methods
  #       new_hash[:phone] = truck.phone
  #       new_hash[:socials] = truck.socials
  #       new_hash[:website] = truck.website
  #       new_hash
  #     end
  # end
  private

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
