class MapFacade
  def self.get_trucks(address) # + radius
    # valid_address = valid_address?(address)
    lat_long = address_to_lat_long(address)
    region = find_closest_region(lat_long)
    truck_data = FoodTruckService.get_schedules_by_city(region)
    trucks = make_trucks(truck_data)
    trucks_with_distances = assign_distances(trucks, lat_long)
    trucks_with_distances
  end

  def self.address_to_lat_long(address)
    MapService.get_coords(address)
  end

  def self.find_closest_region(user_location)
    regions_with_distance = regions.each do |region|
      region_loc = "#{region.lat},#{region.long}"
      user_loc   = "#{user_location[:lat]},#{user_location[:lng]}"
      distance = DistanceService.get_distance(region_loc, user_loc)
      region.add_distance(distance)
    end
    # calling regions method again loses distance data, now stored as regions_with_distance
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
    trucks.each do |truck|
      if truck.lat == "no last location available" || truck.long == "no last location available"
        truck.add_distance(1000)
      else
        truck_loc = "#{truck.lat},#{truck.long}"
        user_loc   = "#{user_location[:lat]},#{user_location[:lng]}"
        require "pry"; binding.pry
        distance = DistanceService.get_distance(truck_loc, user_location)
        truck.add_distance(distance)
      end
    end
  end
end
