class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  validates :body, presence: true

end
