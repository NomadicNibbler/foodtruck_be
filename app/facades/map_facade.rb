class MapFacade
  def self.get_trucks(address) # + radius
    # valid_address = valid_address?(address)
    lat_long = address_to_lat_long(address)
    region = find_closest_region(lat_long)
    truck_data = FoodTruckService.get_schedules_by_city(region)
    trucks = truck_data.map do |data|
      TruckLite.new(data)
    end
    trucks_with_distances = assign_distances(trucks, lat_long)
  end

  # def self.valid_address?(address)
  #
  # end

  def self.address_to_lat_long(address)
    MapService.get_coords(address)
  end

  def self.regions
    regions = parse(FoodTruckService.get_regions)

    regions.map do |region_data|
      Region.new(region_data)
    end
  end

  def self.find_closest_region(user_location)
    regions_with_distance = regions.map do |region|
      region_loc = "#{region.lat},#{region.long}"
      user_loc   = "#{user_location[:lat]},#{user_location[:lng]}"
      region.add_distance(DistanceService.get_distance(region_loc, user_loc))
    end
    # calling regions method again loses distance data, now stored as regions_with_distance
    ordered_regions = regions.order do |region|
      region.distance
    end
    closest_region = ordered_regions[0]
  end

  def self.assign_distances(trucks, user_location)
    trucks.each do |truck|
      truck_loc = "#{truck.lat},#{truck.long}"
      truck.add_distance(DistanceService.get_distance(truck_loc, user_location))
    end
  end

  def self.get_coords(address)
    MapService.get_coords(address)
  end
end
