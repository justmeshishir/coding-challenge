class AnswersController < ApplicationController

  def index
    answers = Answer.where(challenge_id: params[:challenge_id]&.to_i)

    render json: { status: 'success', data: answers.map(&:payload) }, status: :ok
  end

  def create
    answer = Answer.create(answer_params.merge(user_id: current_user.id))
    if answer
      render json: { status: 'success', message: 'Answer Created', data: answer.payload }, status: :created
    else
      render json: { status: 'error', message: 'Answer could not be created' }, status: :unprocessable_entity
    end
  end

  def upvote
    answer = Answer.find(params[:id])
    if answer.upvote_by current_user
      answer.user.upgrade_skill_level if (answer.get_upvotes.size % 10).zero?

      render json: { status: 'success', message: 'Upvoted' }, status: :ok
    else
      render json: { status: 'error', message: 'Could not Upvote' }, status: :unprocessable_entity
    end
  end

  def downvote
    answer = Answer.find(params[:id])
    if current_user.can_downvote?
      answer.downvote_by current_user
      answer.user.downgrade_skill_level if (answer.get_downvotes.size % 5).zero?

      render json: { status: 'success', message: 'Downvoted' }, status: :ok
    else
      render json: { status: 'error', message: 'Could not Downvote. Must have atleast 10 skill level.' }, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :challenge_id)
  end
end
