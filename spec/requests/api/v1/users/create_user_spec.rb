require 'rails_helper'

describe "Users API" do

  it "can create a new user" do
    user_params = {
                    username: 'tsnieuwen',
                    first_name: 'Tommy',
                    last_name: 'Pickles',
                    address: '123 Broadway',
                    city: 'Denver',
                    zipcode: '12345'
                    }

    post "/api/v1/users", params: user_params
    created_user = User.last
    expect(response).to be_successful
    expect(created_user).to be_a(User)
    expect(created_user.username).to eq(user_params[:username])
    expect(created_user.first_name).to eq(user_params[:first_name])
    expect(created_user.last_name).to eq(user_params[:last_name])
    expect(created_user.address).to eq(user_params[:address])
    expect(created_user.city).to eq(user_params[:city])
    expect(created_user.zipcode).to eq(user_params[:zipcode])
  end

end
