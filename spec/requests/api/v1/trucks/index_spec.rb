require 'rails_helper'

RSpec.describe 'trucks index spec' do
  describe 'happy path' do
    before :each do
      @user = User.create!({
                      username: 'tsnieuwen',
                      first_name: 'Tommy',
                      last_name: 'Pickles',
                      address: '898 W Broadway',
                      city: 'Vancouver',
                      zipcode: 'V5Z 1J8'
                      })
    end
    it 'returns an array of all valid trucks in the users proximity', :vcr do
      puts @user.id
      get "/api/v1/trucks?id=#{@user.id}"
      trucks = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(trucks).to be_a(Hash)
      expect(trucks).to have_key(:data)
      expect(trucks[:data][0]).to be_a(Hash)
      expect(trucks[:data][0].keys).to eq([:id, :type, :attributes])
      expect(trucks[:data][0][:type]).to eq("truck")
      expect(trucks[:data][0][:attributes]).to be_a(Hash)
      expect(trucks[:data][0][:attributes].keys).to eq([:lat, :long, :name, :distance, :logo, :payment_methods, :website, :socials, :phone, :description, :display, :description_short])
    end
  end
  # describe 'sad path' do
    # xit 'returns error json' do
    #   get "/api/v1/trucks?id=zip"
    #   body = JSON.parse(response.body, symbolize_names: true)
    #   require "pry"; binding.pry
    #   expect(response).to_not be_successful
    #   expect(response.status).to eq(400)
    #   expect(body).to be_a(Hash)
    #   expect(body).to have_key(:data)
    #   expect(body[:data]).to be_a(Hash)
    #   expect(body[:data].keys).to eq([:error])
    #   expect(body[:data][:error]).to eq("ID not found.")
    # end
  # end
end
