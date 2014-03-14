class FeedbackMailer < ActionMailer::Base
  default from: 'romiborobotproject@gmail.com'
  def email(feedback)
    mail(
        subject: "[RomiboWeb Feedback] #{feedback.name} shared feedback",
        body: feedback.to_json
    )
  end
end