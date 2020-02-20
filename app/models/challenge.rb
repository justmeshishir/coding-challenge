class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :question, presence: true

  enum difficulty_level: %i[easy medium difficult]
end
