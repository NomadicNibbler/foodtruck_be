class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      user_data = MapFacade.return_data(user)
      # trucks = user_data[:trucks]
      render json: UserSerializer.new(user_data), status: 201
    else
      render json: {data: { error: "Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists."}}, status: 400
    end
  end

  private

  def user_params
    params.permit(:username, :first_name, :last_name, :address, :city, :zipcode)
  end

end
