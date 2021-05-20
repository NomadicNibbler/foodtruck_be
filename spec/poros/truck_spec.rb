require 'rails_helper'

RSpec.describe 'Truck' do
  describe 'it can be instantiated' do
    xit 'can have attributes', :vcr do
      raw = FoodTruckService.get_schedules_by_city('vancouver')
      truck = Truck.new(raw.first[1])

      expect(truck).to be_a(Truck)
      expect(truck.lat).to be_a(Float)
      expect(truck.lat).to eq(49.2864661)
      expect(truck.long).to be_a(Float)
      expect(truck.long).to eq(-123.113481)
      expect(truck.name).to eq("arturosmexico2go")
      expect(truck.logo_small).to eq("https://cdn.streetfoodapp.com/images/arturos-to-go/logo/1.90w.png")
    end
  end

  describe "instance methods" do
    xit "#add_distance" do
      data = {
              id: 1,
              lat: 1234567,
              long: 12345,
              name: 'Empanadas Colombiana',
              logo_small: 'small_logo.png'
              }
      truck = Truck.new(data)
      truck.add_distance(1.2)

      expect(truck.distance).to eq(1.2)
    end
  end
end
