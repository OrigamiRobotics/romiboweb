class PaletteMailer < ActionMailer::Base
  default from: 'web@romibo.org'

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
          Rabl::Renderer.new(
              'email',
              @palette,
              :view_path => 'app/views/palettes/share',
              :format => :json
          ).render
      )
    end
  end
end