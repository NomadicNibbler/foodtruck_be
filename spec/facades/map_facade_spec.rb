require 'rails_helper'

RSpec.describe 'the map facade' do
  describe 'happy path' do
    it 'get coords returns coordinate pair for given address' do
      address = '1724 hillcrest dr lander'
      res = MapFacade.get_coords(address)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:lat, :lng])
    end
  end
end
