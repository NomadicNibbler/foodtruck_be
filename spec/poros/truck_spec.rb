require 'rails_helper'

RSpec.describe 'Truck' do
  describe 'it can be instantiated' do
    it 'can have attributes', :vcr do
      raw = FoodTruckService.get_schedules_by_city('vancouver')
      truck = Truck.new(raw.first[1])

      expect(truck).to be_a(Truck)
      expect(truck.lat).to be_a(Float)
      expect(truck.lat).to eq(49.2864661)
      expect(truck.long).to be_a(Float)
      expect(truck.long).to eq(-123.113481)
      expect(truck.name).to eq("arturosmexico2go")
      expect(truck.logo).to eq("https://cdn.streetfoodapp.com/images/arturos-to-go/logo/1.90w@2x.png")
      expect(truck.distance).to eq(0)
      expect(truck.payment_methods).to eq(["cash", "credit_card", "debit_card", "apple_pay"])
      expect(truck.website).to eq('arturos2go.com')
      expect(truck.socials).to eq({:facebook => "arturosmexico2go",
                                   :instagram => "arturos2go",
                                   :twitter => "arturomexico2go"
                                   })
      expect(truck.phone).to eq("(604) 202-4043")
      # expect(truck.description).to eq("Arturo's unique recipes are a fusion of Spanish and traditional Mexican. Clean, simple and healthy M...ing take out food at open spaces since 2010, and we will continue doing it, safety is our priority.")
      expect(truck.description_short).to eq("Authentic, author gourmet Mexican made with the finest ingredients hand picked.")
      expect(truck.display).to eq("Howe St & W Cordova St")
      expect(truck.id).to eq(nil)
      expect(truck.recent_data).to eq(true)
    end
  end

  describe "instance methods" do
    it "#add_distance" do
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
