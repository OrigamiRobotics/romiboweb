class Notification < ActionMailer::Base

  include FeedbackEmail

  default from: "aubreyshick@origamirobotics.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.user_feedback.subject
  #
  def user_feedback(user, feedback)
    @user = user
    @feedback = feedback

    addresses = default_recipients.map{|r| r.email}
    mail(      to:  addresses,
               subject: "User Feedback on RomiboWeb"
    )
  end

  private
  def default_recipients
    recipients = []
    [
      {short_name: "Aubrey", name: "Aubrey Schick", email:  "aubreyshick@origamirobotics.com"},
      {short_name: "Jared", name:  "Jared Peters", email:  "jared@origamirobotics.com"},
      {short_name: "John", name: "John Lee", email:  "john.lee@sv.cmu.edu"},
      {short_name: "Abhi", name: "Abhi Trivedi Lee", email:  "abhi.trivedi@sv.cmu.edu"},
      {short_name: "Danny", name: "Danny Brown", email:  "danny.brown@sv.cmu.edu"}
    ].each do |r|
      recipients << FeedbackEmail::Recipient.new(r[:short_name],
                                                 r[:name],
                                                 r[:email])
    end
    recipients
  end

end
