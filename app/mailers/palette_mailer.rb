class PaletteMailer < ActionMailer::Base
  default from: 'web@romibo.org'

  def share(palette, email)
    mail(
        to: email,
        from: palette.owner.email,
        subject: "Emailing #{palette.title}"
    )
  end
end