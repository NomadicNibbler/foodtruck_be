class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: {data: { error: "Please make sure all fields are filled in before registering. If error persists after filling out fields, username already exists."}}, status: 400
    end
  end

  def update
    user = User.find(update_params[:id])
    if user.update(update_params)
      render json: UserSerializer.new(user), status: 201
    else
      render json: {data: { error: "Please make sure to fill out all appropritate address fields with a valid address."}}, status: 422
    end
  end

  private

  def user_params
    params.permit(:id, :username, :first_name, :last_name, :address, :city, :zipcode)
  end

  def update_params
    params.permit(:id, :address, :city, :zipcode)
  end

end
