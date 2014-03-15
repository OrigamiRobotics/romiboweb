require 'grabzit'

class FeedbackMailer < ActionMailer::Base
  default from: 'romiborobotproject@gmail.com'
  def email(feedback)
    @feedback = feedback
    if feedback.save_screenshot == 1
      screenshot_file = create_screenshot feedback
      attachments["Feedback_img_#{feedback.id}.jpg"] =
          File.read screenshot_file
    end
    mail(
        subject: "[RomiboWeb Feedback] #{feedback.name} shared feedback",
        to: 'romiborobotproject@gmail.com'
    )
  end

  private
  def create_screenshot(feedback)
    client = GrabzIt::Client.new(
        ENV['GRABZIT_KEY'], ENV['GRABZIT_SECRET'])
    client.set_image_options(feedback.page_uri)
    screenshot_file = "#{Rails.root}/tmp/feedback_img_#{feedback.id}.jpg"
    client.save_to.(screenshot_file)
    screenshot_file
  end
end