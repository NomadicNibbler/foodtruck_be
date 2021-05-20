class Api::V1::TrucksController < ApplicationController
  def index
    @user = User.find(user_params[:id])
    if @user
      trucks = MapFacade.get_trucks("#{@user.address}, #{@user.city}, #{@user.zipcode}")
      serialized_data = TruckSerializer.new(trucks)
      render json: serialized_data, status: 200
    else
      render json: {data: { error: "Please enter a valid username."}}, status: 400
    end
  end

  private

  def user_params
    params.permit(:id)
  end
end
