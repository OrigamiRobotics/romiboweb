class FeedbackMailer < ActionMailer::Base
  default from: 'romiborobotproject@gmail.com'
  def email(feedback)
    @feedback = feedback
    mail(
        subject: "[RomiboWeb Feedback] #{feedback.name} shared feedback",
        to: 'romiborobotproject@gmail.com'
    )
  end
end