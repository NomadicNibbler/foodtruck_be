require 'rails_helper'

describe "Users API" do

  it "can login an existing user - happy path", :vcr do
    user_params_existing = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '898 W Broadway',
                    city: 'Vancouver',
                    zipcode: 'V5Z 1J8'
                    }

    user = User.create(user_params_existing)
    full_address = "#{user.address}, #{user.city}, #{user.zipcode}"
    coords = MapService.get_coords(full_address)
    login_params = {username: 'tsnieuwen'}

    post "/api/v1/sessions", params: login_params
    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data].keys).to eq([:id, :type, :attributes])
    expect(user[:data][:type]).to eq("user")
    expect(user[:data][:attributes]).to be_a(Hash)
    expect(user[:data][:attributes].keys).to eq([:username, :first_name, :last_name, :address, :city, :zipcode, :lat, :long])
    expect(user[:data][:attributes][:username]).to eq(user_params_existing[:username])
    expect(user[:data][:attributes][:first_name]).to eq(user_params_existing[:first_name])
    expect(user[:data][:attributes][:last_name]).to eq(user_params_existing[:last_name])
    expect(user[:data][:attributes][:address]).to eq(user_params_existing[:address])
    expect(user[:data][:attributes][:city]).to eq(user_params_existing[:city])
    expect(user[:data][:attributes][:zipcode]).to eq(user_params_existing[:zipcode])
    expect(user[:data][:attributes][:lat]).to eq(49.263345)
    expect(user[:data][:attributes][:long]).to eq(-123.123713)
  end
end
