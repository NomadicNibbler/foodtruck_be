class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if @user
      render json: UserSerializer.new(@user), status: 200
    else
      render json: {data: { error: "Please enter a valid username."}}, status: 400
    end
  end
end
