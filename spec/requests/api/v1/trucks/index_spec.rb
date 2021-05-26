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
  it "can avoid rochester - return an empty array when no trucks in closest region", :vcr do
    user_params = {
                    username: 'w-test-1',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '8808 Burton Rd',
                    city: 'Wonder Lake',
                    zipcode: '60097'
                    }
    user = User.create!(user_params)
    get "/api/v1/trucks?id=#{user.id}"
    trucks = JSON.parse(response.body, symbolize_names: true)

    expect(trucks).to be_a(Hash)
    expect(trucks.keys).to eq([:data])
    expect(trucks[:data]).to eq([])
  end
  describe 'sad path' do
    it 'returns error json' do
      get "/api/v1/trucks?id=zip"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(body).to be_a(Hash)
      expect(body.keys).to eq([:error])
      expect(body[:error]).to eq("Couldn't find User with 'id'=zip")
    end
  end
end
