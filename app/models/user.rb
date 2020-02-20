class User < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

end
