require 'rails_helper'

describe "Happy path update users API" do
  before :each do
    user_params = {
      username: 'tsnieuwen',
      first_name: 'Tommy',
      last_name: 'Pickles',
      address: '898 W Broadway',
      city: 'Vancouver',
      zipcode: 'V5Z 1J8'
    }
    @user = User.create(user_params)
    @full_address = "#{user_params[:address]}, #{user_params[:city]}, #{user_params[:zipcode]}"
    @coords = MapService.get_coords(@full_address)
  end

  it "can update an existing user - happy path" do
    updated_user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '433 Robson St',
                    city: 'Vancouver',
                    zipcode: 'V6B 6L9'
                    }

    updated_full_address = "#{updated_user_params[:address]}, #{updated_user_params[:city]}, #{updated_user_params[:zipcode]}"
    updated_coords = MapService.get_coords(updated_full_address)
    patch "/api/v1/users/#{@user.id}", params: updated_user_params
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
    expect(user[:data][:attributes][:username]).to eq(updated_user_params[:username])
    expect(user[:data][:attributes][:first_name]).to eq(updated_user_params[:first_name])
    expect(user[:data][:attributes][:last_name]).to eq(updated_user_params[:last_name])
    expect(user[:data][:attributes][:address]).to eq(updated_user_params[:address])
    expect(user[:data][:attributes][:city]).to eq(updated_user_params[:city])
    expect(user[:data][:attributes][:zipcode]).to eq(updated_user_params[:zipcode])
    expect(user[:data][:attributes][:lat]).to eq(updated_coords[:lat])
    expect(user[:data][:attributes][:long]).to eq(updated_coords[:lng])
  end

  describe "Sad path " do
    it "can update an existing user - sad path - no address" do
      updated_user_params = {
                      username: 'tsnieuwen',
                      first_name: 'Tommy',
                      last_name: 'Pickles',
                      address: '',
                      city: 'Vancouver',
                      zipcode: 'V6B 6L9'
                      }

      patch "/api/v1/users/#{@user.id}", params: updated_user_params
      user = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data].keys).to eq([:error])
      expect(user[:data][:error]).to eq("Please make sure to fill out all appropritate address fields with a valid address.")
    end

    it "can create a new user - sad path - no city" do
      updated_user_params = {
                      username: 'tsnieuwen',
                      first_name: 'Tommy',
                      last_name: 'Pickles',
                      address: '433 Robson St',
                      city: '',
                      zipcode: 'V6B 6L9'
                      }

      patch "/api/v1/users/#{@user.id}", params: updated_user_params
      user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data].keys).to eq([:error])
      expect(user[:data][:error]).to eq("Please make sure to fill out all appropritate address fields with a valid address.")
    end

    it "can create a new user - sad path - no zipcode" do
      updated_user_params = {
                      username: 'tsnieuwen',
                      first_name: 'Tommy',
                      last_name: 'Pickles',
                      address: '433 Robson St',
                      city: 'Vancouver',
                      zipcode: ''
                      }

      patch "/api/v1/users/#{@user.id}", params: updated_user_params
      user = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
      expect(user[:data].keys).to eq([:error])
      expect(user[:data][:error]).to eq("Please make sure to fill out all appropritate address fields with a valid address.")
    end
  end
end
