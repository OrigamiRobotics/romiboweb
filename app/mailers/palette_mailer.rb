require 'json'
# PaletteMailer extends ActionMailer for sending email notifications.
#

class PaletteMailer < ActionMailer::Base
  default from: 'web@romibo.org'

  ##
  # Send share Palette email to email that is defined. Invoked from Palettes::ShareController create().
  #
  # * *Args*    :
  #   - +palette+ -> Palette to be shared.
  #   - +email+ -> Email destination for shared Palette.
  # * *Returns* :
  #   - void
  # * *Raises* :
  #   - +ArgumentError+ -> if any value is nil or negative
  ##
  def share(palette, email)
    write_to_file palette
    attachments["#{palette.title}.rmbo"] =
        File.read("#{Rails.root}/tmp/#{palette.title}.rmbo.txt")
    mail(
        to: email,
        from: palette.owner.email,
        subject: "Emailing #{palette.title}",
        body: palette.title
    )
    File.delete("#{Rails.root}/tmp/#{palette.title}.rmbo.txt")
  end

  private
  def write_to_file(palette)
    @palette = palette
    File.open("#{Rails.root}/tmp/#{palette.title}.rmbo.txt", 'w') do |f|
      f.write(
          JSON.pretty_generate PaletteSerializer.new(@palette).as_json
      )
    end
  end
end
