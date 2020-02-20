class UsersController < ApplicationController
  skip_before_action :require_login!, only: [:signup]

  def signup
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :ok
    else
      render json: { status: 'error', message: @user.errors }, status: :unprocessable_entity
    end
  end

  def signin
    if current_user.present?
      render json: current_user
    else
      render json: { status: 'not found', message: 'User not found' }, status: :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end
