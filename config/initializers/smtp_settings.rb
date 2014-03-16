# Based on http://railscasts.com/episodes/206-action-mailer-in-rails-3
#ActionMailer::Base.smtp_settings = {
#  address: 'smtp.gmail.com',
#  port: '587',
#  user_name: ENV['SMTP_USERNAME'],
#  password: ENV['SMTP_PASSWORD'],
#  authentication: :plain,
#  enable_starttls_auto: true
#}
#ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if
#    Rails.env.development?
