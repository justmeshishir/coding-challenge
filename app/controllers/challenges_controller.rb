class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.order('created_at DESC')
    @challenges.find_by(user_id: params[:user][:user_id].to_i) if params[:user][:user_id].present?
  end

  def create
    @challenge = Challenge.create(challenge_params)
    if @challenge
      render json: { status: 'success', message: 'Challenge created', data: @challenge }, status: :created
    else
      render json: { status: 'error', message: @challenge.errors }, status: :unprocessable_entity
    end
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :description, :question, :category_name, :difficulty_level, :user_id)
  end
end
