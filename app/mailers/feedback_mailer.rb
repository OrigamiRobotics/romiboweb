require 'grabzit'

class FeedbackMailer < ActionMailer::Base
  default from: 'romiborobotproject@gmail.com'
  def email(feedback, save_screenshot)
    @feedback = feedback
    if save_screenshot
      screenshot_file = create_screenshot feedback
      attachments['Page_Screenshot.jpg'] =
          File.read("#{Rails.root}/#{screenshot_file}")
    end
    mail(
        subject: "[RomiboWeb Feedback]: #{feedback.statement}",
        to: 'romiborobotproject@gmail.com'
    )
  end

  private
  def create_screenshot(feedback)
    client = GrabzIt::Client.new(
        ENV['GRABZIT_KEY'], ENV['GRABZIT_SECRET'])
    page_uri = feedback.page_uri
    page_uri = 'http://www.google.com' if Rails.env.development?
    client.set_image_options(page_uri)
    screenshot_file = "tmp/feedback_img_#{feedback.id}.jpg"
    client.save_to(screenshot_file)
    screenshot_file
  end
end