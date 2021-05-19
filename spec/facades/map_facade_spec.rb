require "rails_helper"

RSpec.describe "map_facade_spec" do
  describe "class methods" do
    it "#get_trucks", :vcr do
      address = 'Library Square, 345 Robson St, Vancouver, BC V6B 6B3, Canada'
      trucks = MapFacade.get_trucks(address)
      expect(trucks).to be_an(Array)
      expect(trucks.first).to be_a(TruckLite)
      expect(trucks.count).to eq(96) #45
      expect(trucks.first.lat).to eq(49.2864661)
      expect(trucks.first.long).to eq(-123.113481)
      expect(trucks.first.name).to eq("arturosmexico2go")
      expect(trucks.first.distance).to eq(0.8)
      expect(trucks.first.logo_small).to eq("https://cdn.streetfoodapp.com/images/arturos-to-go/logo/1.90w.png")
    end

    it "#address_to_lat_long", :vcr do
      address = 'Library Square, 345 Robson St, Vancouver, BC V6B 6B3, Canada'
      lat_long = MapFacade.address_to_lat_long(address)
      expect(lat_long).to eq({:lat=>49.2797, :lng=>-123.11556})
    end

    it "#get_distance" do
      truck_location = '49.28976,-123.12556'
      user_location = '41.379736,-123.11556'

      distance = MapFacade.get_distance(truck_location, user_location)
      expect(distance).to eq(879.5548835183268)
    end

    it "#find_closest_region" do
      lat_long = {:lat=>49.2797, :lng=>-123.11556}
      formatted_lat_long = "#{lat_long[:lat]},#{lat_long[:lng]}"
      region = MapFacade.find_closest_region(formatted_lat_long)

      expect(region).to eq("vancouver")
    end

    it "#make_trucks", :vcr do
      truck_data =FoodTruckService.get_schedules_by_city('vancouver')
      trucks = MapFacade.make_trucks(truck_data)
      expect(trucks.first).to be_a(TruckLite)
      expect(trucks.length).to eq(96)
    end

    it "#regions", :vcr do
      region_objects = MapFacade.regions

      expect(region_objects).to be_an(Array)
      expect(region_objects.count).to eq(77)
      expect(region_objects.first.name).to eq("Abbotsford")
    end


    it "#assign_distances", :vcr do
      user_location = '49.2797,-123.11556'
      truck_data = FoodTruckService.get_schedules_by_city('vancouver')
      trucks = MapFacade.make_trucks(truck_data)
      trucks_with_distances = MapFacade.assign_distances(trucks, user_location)
      expect(trucks_with_distances.length).to eq(96)
      expect(trucks_with_distances.first.distance).to eq(0.8)
      expect(trucks_with_distances.last.distance).to eq(4.8)
    end
  end

  describe "sad paths" do
    xit "#get_trucks returns empty array if no trucks are in the area" do
      address = '13 Home st. Worcester, MA 10609'
      trucks = MapFacade.get_trucks(address)

      expect(trucks).to eq ([])
    end

    xit "#get_trucks returns empty array if given empty string" do
      address = ' '
      trucks = MapFacade.get_trucks(address)

      expect(trucks).to eq ([])
    end

    xit "#get_trucks returns empty array if given bad address" do
      address = '123 fake st. Milwaukee, WI 53146'
      trucks = MapFacade.get_trucks(address)

      expect(trucks).to eq ([])
    end

    xit "#address_to_lat_long returns can handle bad address" do
      address = '123 fake st. Milwaukee, WI 53146'
      lat_long = MapFacade.address_to_lat_long(address)

      expect(lat_long).to eq('{ error: please enter a valid address }')
    end

    xit "when given bad lat_long it returns error" do
      lat_long = '{lat: 123.12234, long: 1234.1234}'
      region = MapFacade.get_region(lat_long)

      expect(region).to eq('{error: please enter valid lat_long}')
    end
  end
end
