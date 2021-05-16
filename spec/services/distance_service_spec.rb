require 'rails_helper'

RSpec.describe 'distance service' do
  describe 'class methods' do
    it '#get_distance', :vcr do
      origin = "40.6655101,-73.89188969999998"
      destination = "40.6905615,-73.9976592"
      response = DistanceService.get_distance(origin, destination)
      expect(response.status).to eq(200)
      response = parse(response)

      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:destination_addresses, :origin_addresses, :rows, :status])
      expect(response[:origin_addresses]).to eq(["P.O. Box 793, Brooklyn, NY 11207, USA"])
      expect(response[:destination_addresses]).to eq(["339 Hicks St, Brooklyn, NY 11201, USA"])
      expect(response[:rows]).to be_an(Array)
      expect(response[:rows].first[:elements]).to be_an(Array)
      expect(response[:rows].first[:elements].first[:distance]).to be_an(Hash)
      expect(response[:rows].first[:elements].first[:distance][:text]).to eq("6.5 mi")
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
