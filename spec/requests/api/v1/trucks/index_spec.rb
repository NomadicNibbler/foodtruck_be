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
    xit 'returns an array of all valid trucks in the users proximity', :vcr do
      puts @user.id
      get "/api/v1/trucks?id=#{@user.id}"
      user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data].keys).to eq([:id, :type, :attributes])
      expect(user[:data][:type]).to eq("user")
      expect(user[:data][:attributes]).to be_a(Hash)
      expect(user[:data][:attributes].keys).to eq([:username, :first_name, :last_name, :address, :city, :zipcode])
      expect(user[:data][:attributes][:username]).to eq(@user.username)
      expect(user[:data][:attributes][:first_name]).to eq(@user.first_name)
      expect(user[:data][:attributes][:last_name]).to eq(@user.last_name)
      expect(user[:data][:attributes][:address]).to eq(@user.address)
      expect(user[:data][:attributes][:city]).to eq(@user.city)
      expect(user[:data][:attributes][:zipcode]).to eq(@user.zipcode)
    end
  end
  describe 'sad path' do
    xit 'returns error json' do
      post "/api/v1/sessions?username=beeps"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body).to be_a(Hash)
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("Please enter a valid username.")
    end
  end
end
