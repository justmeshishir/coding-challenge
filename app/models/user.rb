class User < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password
  acts_as_voter

  before_validation do
    self.email = email.to_s.downcase
  end

  validates_length_of :password_digest, maximum: 72, minimum: 8
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

  before_create :create_api_token

  def payload
    {
      id: id,
      email: email,
      username: username,
      first_name: first_name,
      last_name: last_name,
      skill_level: skill_level,
      api_token: api_token
    }
  end

  def create_api_token
    begin
      self.api_token = SecureRandom.hex
    end while self.class.exists?(api_token: api_token)
  end

  def upgrade_skill_level
    self.skill_level = skill_level + 1
    notify_voters
  end

  def downgrade_skill_level
    self.skill_level = skill_level - 1
  end

  def can_downvote?
    skill_level >= 10
  end

  private

  def notify_voters
    get_upvotes.last(10).each do |voter|
      NotificationMailer.thank_for_upvote(voter, self).deliver_later
    end
  end
end
