# kindly generated by appropriated Rails generator
require 'mailjet'

Mailjet.configure do |config|
  config.api_key = '21a3c01a0d5978e4c92d67999f0b3c09'
  config.secret_key = '5b368ee6b5ab23f55b3489ddbb7a76e2'
  config.default_from = 'glowup.chatgenie@gmail.com'
  # Mailjet API v3.1 is at the moment limited to Send API.
  # We’ve not set the version to it directly since there is no other endpoint in that version.
  # We recommend you create a dedicated instance of the wrapper set with it to send your emails.
  # If you're only using the gem to send emails, then you can safely set it to this version.
  # Otherwise, you can remove the dedicated line into config/initializers/mailjet.rb.
  config.api_version = 'v3.1'
end
