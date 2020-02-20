class AnswersController < ApplicationController

  def index
    answers = Answer.where(challenge_id: params[:answer][:challenge_id]&.to_s)

    render json: {status: 'success', data: answers }, status: :ok
  end

  def create
    answer = Answer.create(answer_params.merge(user_id: current_user.id))
    if answer
      render json: { status: 'success', message: 'Answer Created', data: answer }, status: :created
    else
      render json: { status: 'error', message: 'Answer could not be created' }, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :challenge_id)
  end
end
