class AfterConfirmationMailer < ActionMailer::Base

  def welcome_mailer(user)
    @user = user

    mail(
        from: 'origamirobotics@gmail.com',
        to:  user.email,
        subject: "Welcome to RomiboWeb"
    )
  end

end