class Api::V1::TrucksController < ApplicationController
  def index
    @user = User.find(user_params[:id])
    if @user
      trucks = MapFacade.get_trucks("#{@user.address}, #{@user.city}, #{@user.zipcode}")
      if trucks == "location not found"
        render json: { data: { error: "Location invalid, please enter another location" }}
      else
        serialized_data = TruckSerializer.new(trucks)
        render json: serialized_data, status: 200
      end
    else
      render json: {data: { error: "ID not found."}}, status: 400
    end
  end

  private

  def user_params
    params.permit(:id)
  end
end
