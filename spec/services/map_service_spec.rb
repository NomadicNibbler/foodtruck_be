require 'rails_helper'

RSpec.describe 'the map service' do
  describe 'happy path' do
    it 'get coords returns coordinate pair for given address' do
      VCR.use_cassette('coords_happy') do
        address = '1724 hillcrest dr lander'
        res = MapService.get_coords(address)

        expect(res).to be_a(Hash)
        expect(res.keys).to eq([:lat, :lng])
        expect(res[:lat]).to be_a(Float)
        expect(res[:lng]).to be_a(Float)
      end
    end
  end
end
