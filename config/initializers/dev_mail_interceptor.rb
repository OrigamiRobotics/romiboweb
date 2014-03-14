# Based on http://railscasts.com/episodes/206-action-mailer-in-rails-3
#class DevelopmentMailInterceptor
#  def self.delivering_email(message)
#    message.subject = "#{message.to} #{message.subject}"
#    message.to = ENV['SMTP_DEV_EMAIL']
#  end
#end