# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Moonrise::Application.initialize!


Moonrise::Application.configure do config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { 
  address: "smtp.gmail.com",
  port: 587,
  domain: "minkmeadow.com", 
  authentication: "plain",
  user_name: ENV['GMAIL_USERNAME'], 
  password: ENV['GMAIL_PASSWORD'], 
  enable_starttls_auto: true
}
end