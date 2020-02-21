class UsersController < ApplicationController
  skip_before_action :require_login!, only: [:signup, :signin]

  def signup
    user = User.new(user_params)
    if user.save
      render json: {status: 'success', message: 'User created'}, status: :created
    else
      render json: { status: 'error', message: user.errors }, status: :unprocessable_entity
    end
  end

  def signin
    user = User.find_by_email(params[:email])
    if user && user&.authenticate(params[:password])
      render json: { status: 'success', messages: 'Signed In', data: user.payload }, status: :ok
    else
      render json: { status: 'not found', message: 'User not found' }, status: :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end
