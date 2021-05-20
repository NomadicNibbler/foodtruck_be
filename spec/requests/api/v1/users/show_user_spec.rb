require 'rails_helper'

describe "Users API" do

  xit "can login an existing user - happy path" do
    user_params_existing = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '123 Broadway',
                    city: 'Denver',
                    zipcode: '12345'
                    }

    User.create(user_params_existing)

    login_params = {username: 'tsnieuwen'}

    get "api/v1/users", params: login_params
    user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data].keys).to eq([:id, :type, :attributes])
    expect(user[:data][:type]).to eq("user")
    expect(user[:data][:attributes]).to be_a(Hash)
    expect(user[:data][:attributes].keys).to eq([:username, :first_name, :last_name, :address, :city, :zipcode])
    expect(user[:data][:attributes][:username]).to eq(user_params[:username])
    expect(user[:data][:attributes][:first_name]).to eq(user_params[:first_name])
    expect(user[:data][:attributes][:last_name]).to eq(user_params[:last_name])
    expect(user[:data][:attributes][:address]).to eq(user_params[:address])
    expect(user[:data][:attributes][:city]).to eq(user_params[:city])
    expect(user[:data][:attributes][:zipcode]).to eq(user_params[:zipcode])
  end

end
