require "rails_helper"

RSpec.describe "map_facade_spec" do
  describe "class methods" do
    it "#get_trucks" do
      address = 'Library Square, 345 Robson St, Vancouver, BC V6B 6B3, Canada'
      data = MapFacade.get_trucks(address)
      trucks = parse(data)

      expect(trucks).to be_an(Array)
      expect(trucks.first).to be_a(Truck)
      expect(trucks.count).to eq(45)
      expect(trucks.first.id).to eq(23)
      expect(trucks.first.latitude).to eq(53.23657)
      expect(trucks.first.longitude).to eq(24.36676)
      expect(trucks.first.name).to eq("Abbotsford")
      expect(trucks.first.distance).to eq(1.4)
      expect(trucks.first.logo_small).to eq("small_logo.png")
    end

    it "#address_to_lat_long", :vcr do
      address = 'Library Square, 345 Robson St, Vancouver, BC V6B 6B3, Canada'
      lat_long = MapFacade.address_to_lat_long(address)
      expect(lat_long).to eq({:lat=>49.2797, :lng=>-123.11556})
    end

    it "#find_closest_region", :vcr do
      address = 'Library Square, 345 Robson St, Vancouver, BC V6B 6B3, Canada'
      lat_long = {:lat=>49.2797, :lng=>-123.11556}
      data = MapFacade.find_closest_region(lat_long)
      region = parse(data)

      expect(region).to eq("Vancouver")
    end

    xit "when given lat_long it returns the closest region" do
      lat_long = '{lat: 123.12234, long: 1234.1234}'
      region = MapFacade.get_region(lat_long)

      expect(region).to eq('Vancouver')
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
