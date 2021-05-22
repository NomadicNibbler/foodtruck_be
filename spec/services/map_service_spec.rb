require 'rails_helper'

RSpec.describe 'the map service' do
  describe 'class methods' do
    it '#get_coords', :vcr do
      address = '898 W Broadway Vancouver V5Z 1J8'
      res = MapService.get_coords(address)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:lat, :lng])
      expect(res[:lat]).to be_a(Float)
      expect(res[:lng]).to be_a(Float)
    end
  end
  describe 'sad path' do

  end
end
