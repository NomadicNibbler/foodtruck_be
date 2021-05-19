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
    MapService.get_coords(address)
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
      TruckLite.new(data[1])
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
      truck.lat == "no last location available" || truck.long == "no last location available"
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
end
