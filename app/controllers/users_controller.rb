class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
      wait 1
    else
      render json: {data: { error: "Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists."}}, status: 400
    end
  end

  private

  def user_params
    params.permit(:username, :first_name, :last_name, :address, :city, :zipcode)
  end

end
