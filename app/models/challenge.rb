class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :question, presence: true

  enum difficulty_level: %i[easy medium difficult]
end
