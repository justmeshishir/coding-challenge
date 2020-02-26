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

  def self.top_challenges(start_date = nil, end_date = nil)
    start_date ||= Date.today
    end_date ||= Date.today + 1.week

    q =
    <<-SQL
    SELECT id, answer_count
    FROM (
      SELECT c.id, COUNT(a.id) AS answer_count
      FROM challenges c, answers a
      WHERE a.challenge_id = c.id
      AND c.created_at >= '#{start_date.to_s}'
      AND c.created_at <= '#{end_date.to_s}'
      GROUP BY c.id
      ORDER BY 2 DESC ) as ans
      LIMIT 5;
    SQL
    ActiveRecord::Base.connection.exec_query(q).map{ |x| OpenStruct.new(x) }
  end
end
