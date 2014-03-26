# AfterConfirmationMailer extends ActionMailer for sending email notifications.
#

class AfterConfirmationMailer < ActionMailer::Base

  ##
  # Send welcome email to new user. Invoked from User
  #
  # * *Args*    :
  #   - +user+ -> User
  # * *Returns* :
  #   - void
  # * *Raises* :
  #   - +ArgumentError+ -> if any value is nil or negative
  ##
  def welcome_mailer(user)
    @user = user

    mail(
        from: 'origamirobotics@gmail.com',
        to:  user.email,
        subject: "Welcome to RomiboWeb"
    )
  end

end