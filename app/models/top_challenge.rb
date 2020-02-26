class TopChallenge < ApplicationRecord
  belongs_to :challenge

  def self.new_week_challenge
    start_date = Date.today
    end_date = start_date + 1.week
    challenges = Challenge.top_challenges(start_date, end_date)

    challenges.each do |challenge|
      create(start_date: start_date, end_date: end_date, challenge_id: challenge.id)
    end
  end
end
