CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: "AWS",
      ##aws_access_key_id: ENV["AWS_ACCESS_KEY"],
      ##aws_secret_access_key: ENV["AWS_SECRET_CODE"]
      aws_access_key_id: "AKIAIYCSHSDOKCKQJ6MA",
      aws_secret_access_key: "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",
      region: 'us-west-2'
  }

  if Rails.env.production?
    config.fog_directory = "romiboweb"
  elsif Rails.env.staging?
    config.fog_directory = "romibowebstaging"
  elsif Rails.env.integration?
    config.fog_directory = "romibowebintegration"
  else
    config.fog_directory = "romibowebdevelopment"
  end
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_public = true
end