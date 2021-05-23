require 'rails_helper'

describe "Users API" do

  it "can create a new user - happy path" do
    user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '898 W Broadway',
                    city: 'Vancouver',
                    zipcode: 'V5Z 1J8'
                    }
    full_address = "#{user_params[:address]}, #{user_params[:city]}, #{user_params[:zipcode]}"
    coords = MapService.get_coords(full_address)


    post "/api/v1/users", params: user_params
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data].keys).to eq([:id, :type, :attributes])
    expect(user[:data][:type]).to eq("user")
    expect(user[:data][:attributes]).to be_a(Hash)
    expect(user[:data][:attributes].keys).to eq([:username, :first_name, :last_name, :address, :city, :zipcode, :lat, :long])
    expect(user[:data][:attributes][:username]).to eq(user_params[:username])
    expect(user[:data][:attributes][:first_name]).to eq(user_params[:first_name])
    expect(user[:data][:attributes][:last_name]).to eq(user_params[:last_name])
    expect(user[:data][:attributes][:address]).to eq(user_params[:address])
    expect(user[:data][:attributes][:city]).to eq(user_params[:city])
    expect(user[:data][:attributes][:zipcode]).to eq(user_params[:zipcode])
    expect(user[:data][:attributes][:lat]).to eq(coords[:lat])
    expect(user[:data][:attributes][:long]).to eq(coords[:lng])
  end

  it "can create a new user - sad path - no username" do
    user_params = {
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '123 Broadway',
                    city: 'Denver',
                    zipcode: '12345'
                    }

    post "/api/v1/users", params: user_params
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end

  it "can create a new user - sad path - username already exists" do
    user_params_existing = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '4 Yawkey Way',
                    city: 'Boston',
                    zipcode: '02215'
                    }

    existing_user = User.create(user_params_existing)
    user_params_new = {
                    username: 'tsnieuwen',
                    first_name: 'Dill',
                    last_name: 'Mayo',
                    address: '12345 Main',
                    city: 'Aurora',
                    zipcode: '54321'
                    }

    post "/api/v1/users", params: user_params_new
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end

  it "can create a new user - sad path - no first name" do
    user_params = {
                    username: 'tsnieuwen',
                    last_name: 'Pickles',
                    address: '123 Broadway',
                    city: 'Denver',
                    zipcode: '12345'
                    }

    post "/api/v1/users", params: user_params
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end

  it "can create a new user - sad path - no last name" do
    user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    address: '123 Broadway',
                    city: 'Denver',
                    zipcode: '12345'
                    }

    post "/api/v1/users", params: user_params
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end

  it "can create a new user - sad path - no address" do
    user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    city: 'Denver',
                    zipcode: '12345'
                    }

    post "/api/v1/users", params: user_params
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end

  it "can create a new user - sad path - no city" do
    user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '123 Broadway',
                    zipcode: '12345'
                    }

    post "/api/v1/users", params: user_params
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end

  it "can create a new user - sad path - no zipcode" do
    user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '123 Broadway',
                    city: 'Denver',
                    }

    post "/api/v1/users", params: user_params
    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(body).to be_a(Hash)
    expect(body).to have_key(:data)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists.")
  end


end
