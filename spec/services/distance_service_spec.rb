require 'rails_helper'

RSpec.describe 'distance service' do
  describe 'class methods' do
    it '#get_distance', :vcr do
      origin = "40.6655101,-73.89188969999998"
      destination = "40.6905615,-73.9976592"
      response = DistanceService.get_distance(origin, destination)
      expect(response).to be_a(Float)
      expect(response).to eq(6.5)
    end
  end
  describe 'sad path' do
    it "returns 'NOT_FOUND' for invalid destination" do
      origin = "40.6655101,-73.89188969999998"
      destination = "40.6905615,-100000000"
      response = DistanceService.get_distance(origin, destination)
      expect(response.status).to eq(200)
      response = parse(response)

      expect(response[:rows].first[:elements].first[:status]).to eq("NOT_FOUND")
    end
  end
end
