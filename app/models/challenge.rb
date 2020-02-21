class Challenge < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :question, presence: true

  enum difficulty_level: %i[easy medium difficult]

  def top_challenges
    Challenge.last(10)
  end
end
