require 'rails_helper'

RSpec.describe 'TruckLite' do
  describe 'it can be instantiated' do
    it 'can have attributes' do
      data = {
              id: 1,
              lat: 1234567,
              long: 12345,
              name: 'Empanadas Colombiana',
              logo_small: 'small_logo.png'
              }
        truck = TruckLite.new(data)

        expect(truck).to be_a(TruckLite)
        expect(truck.id).to eq(1)
        expect(truck.lat).to be_a(Float)
        expect(truck.lat).to eq(1234567)
        expect(truck.long).to be_a(Float)
        expect(truck.long).to eq(12345)
        expect(truck.name).to eq("Empanadas Colombiana")
        expect(truck.logo).to eq("small_logo.png")
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
        truck = TruckLite.new(data)
        truck.add_distance(1.2)

        expect(truck.distance).to eq(1.2)
      end
    end
  end
