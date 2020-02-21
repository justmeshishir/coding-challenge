class NotificationMailer < ApplicationMailer

  def thank_for_upvote(voter, answer)
    @voter = voter
    @answer = answer

    mail(to: @voter.email, subject: "Thank You for your vote!")
  end
end
