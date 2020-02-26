class Challenge < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :top_challenges, dependent: :destroy

  validates :name, presence: true
  validates :question, presence: true

  enum difficulty_level: %i[easy medium difficult]

  def payload
    {
      id: id,
      name: name,
      description: description,
      question: question,
      difficulty_level: difficulty_level,
      user_id: user.id,
      category_name: category_name,
      answers: answers.map(&:payload)
    }
  end

  def self.top_challenges
    Challenge.last(10)
  end
end
