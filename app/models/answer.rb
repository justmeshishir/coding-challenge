class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  validates :body, presence: true

  acts_as_votable

  def payload
    {
      id: id,
      body: body,
      challenge_id: challenge.id,
      user_id: user.id,
      created_at: created_at
    }
  end
end
