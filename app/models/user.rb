class User < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  before_validation do
    self.email = email.to_s.downcase
  end

  validates_length_of :password_digest, maximum: 72, minimum: 8
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

  before_create :create_api_token

  def create_api_token
    begin
      self.api_token = SecureRandom.hex
    end while self.class.exists?(api_token: api_token)
  end
end
