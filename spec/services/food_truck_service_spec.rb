require "rails_helper"

RSpec.describe "Food_truck_service_api" do
  describe "class methods" do
    it "returns all the possible regions", :vcr do
      data = FoodTruckService.get_regions
      expect(data.status).to eq(200)
      regions = parse(data)

      expect(regions).to be_an(Array)
      expect(regions.count).to eq(77)
      expect(regions.first).to be_a(Hash)
      expect(regions.first[:identifier]).to eq('abbotsford')
      expect(regions.first[:latitude]).to eq(49.0504377)
      expect(regions.first[:longitude]).to eq(-122.3044697)
      expect(regions.first[:name]).to eq("Abbotsford")
    end

    it "when given a location it returns all the food trucks in the area", :vcr do
      region_identifier = 'vancouver'
      trucks = FoodTruckService.get_schedules_by_city(region_identifier)

      expect(trucks.first[1]).to be_a(Hash)
      expect(trucks.first[1][:description_short]).to eq("Authentic, author gourmet Mexican made with the finest ingredients hand picked.")
      expect(trucks.first[1][:description]).to eq("Arturo's unique recipes are a fusion of Spanish and traditional Mexican. Clean, simple and healthy Mexican food. Only 3 people prepare the food we serve to our clients, from the local produce and local butcher, there is not third parties when it comes to prepare our dishes. We closely follow Health Authority guidances and protocols to operate our business. We have been serving take out food at open spaces since 2010, and we will continue doing it, safety is our priority.")
      expect(trucks.first[1][:name]).to eq("arturosmexico2go")
      expect(trucks.first[1][:region]).to eq("vancouver")
      expect(trucks.first[1][:phone]).to eq("(604) 202-4043")
      expect(trucks.first[1][:email]).to eq("info@arturos2go.com")
      expect(trucks.first[1][:twitter]).to eq("arturomexico2go")
      expect(trucks.first[1][:facebook]).to eq("arturosmexico2go")
      expect(trucks.first[1][:instagram]).to eq("arturos2go")
      expect(trucks.first[1][:name]).to eq("arturosmexico2go")
      expect(trucks.first[1][:payment_methods]).to eq(["cash", "credit_card", "debit_card", "apple_pay"])
      expect(trucks.first[1][:images][:logo_small]).to eq("https://cdn.streetfoodapp.com/images/arturos-to-go/logo/1.90w.png")
      expect(trucks.first[1][:open]).to be_an(Array)
      expect(trucks.first[1][:open].length).to eq(6)
      expect(trucks.first[1][:open].first.keys).to eq([:start, :end, :display, :updated, :latitude, :longitude])
    end
  end

  describe "sad paths" do
    it "handles HTML return" do
      region_identifier = 'rochester'
      trucks = FoodTruckService.get_schedules_by_city(region_identifier)

      expect(trucks). to eq("no nearby trucks")
    end
  #   xit "returns a 404 for integers" do
  #     trucks = FoodTruckService.get_schedules_by_city("2345")
  #     require "pry"; binding.pry
  #     expect(trucks.status).to eq(404)
  #   end
  #
  #   xit "returns a 404 for invalid" do
  #     trucks = FoodTruckService.get_schedules_by_city("hello")
  #
  #     expect(trucks.status).to eq(404)
  #   end
  #
  #   it "returns a 404 if not a valid city" do
  #     trucks = FoodTruckService.get_schedules_by_city("worcester")
  #
  #     expect(trucks.status).to eq(404)
  #   end
  end
end
