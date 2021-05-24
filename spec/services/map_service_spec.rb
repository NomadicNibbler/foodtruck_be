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
    it '#get_coords - api corrects for minor errors when mostly correct', :vcr do
      address = '898 W Breadway Vancouver V5Z 1J8'
      result = MapService.get_coords(address)
      expect(result).to be_a(Hash)
      expect(result.keys).to eq([:lat, :lng])
      expect(result[:lat]).to be_a(Float)
      expect(result[:lng]).to be_a(Float)
    end
    it '#get_coords returns error message for empty address', :vcr do
      address = ''
      result = MapService.get_coords(address)

      expect(result).to be_a(String)
      expect(result).to eq("location not found")
    end
    it '#get_coords returns error message for nonsense address', :vcr do
      address = 'aldsfkjhlkj34h56lk3j4hdjfshg1232skjdfgh'
      result = MapService.get_coords(address)
      expect(result).to be_a(String)
      expect(result).to eq("location not found")
    end
  end
end
