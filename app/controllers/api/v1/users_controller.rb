class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
  end

  private

  def user_params
    params.permit(:username, :first_name, :last_name, :address, :city, :zipcode)
  end

end
