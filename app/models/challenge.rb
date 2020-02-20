class Challenge < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :question, presence: true

  enum difficulty_level: %i[easy medium difficult]
end
