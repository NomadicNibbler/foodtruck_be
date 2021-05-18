require 'rails_helper'

RSpec.describe 'Region' do
  describe 'it can be instantiated' do
    it 'can have attributes' do
      data = {
                :identifier=>"abbotsford",
               :name=>"Abbotsford",
               :name_long=>"Abbotsford, BC",
               :time_zone=>"America/Vancouver",
               :latitude=>49.0504377,
               :longitude=>-122.3044697,
               :country=>"ca",
               :example_location=>{:address=>"S Fraser Way & Trethewey St", :latitude=>49.051676, :longitude=>-122.326484},
               :regions=>[]
             }
      region = Region.new(data)

      expect(region).to be_a(Region)
      expect(region.lat).to be_a(Float)
      expect(region.lat).to eq(49.0504377)
      expect(region.long).to be_a(Float)
      expect(region.long).to eq(-122.3044697)
      expect(region.country).to eq("ca")
    end
  end
end
