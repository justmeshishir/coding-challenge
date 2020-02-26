class ChallengesController < ApplicationController
  def index
    challenges = Challenge.order('created_at DESC')
    challenges = challenges.where(user_id: params[:user_id].to_i) if params[:user_id].present?

    render json: { status: 'success', data: challenges.map(&:payload) }, status: :ok
  end

  def create
    challenge = Challenge.create(challenge_params.merge(user_id: current_user.id))
    if challenge
      render json: { status: 'success', message: 'Challenge created', data: challenge.payload }, status: :created
    else
      render json: { status: 'error', message: challenge.errors }, status: :unprocessable_entity
    end
  end

  def top_challenges
    challenges = TopChallenge.last(10).map(&:challenge)
    render json: { status: 'success', data: challenges.map(&:payload) }, status: :ok
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :description, :question, :category_name, :difficulty_level)
  end
end
