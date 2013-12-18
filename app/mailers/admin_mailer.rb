class AdminMailer < ActionMailer::Base
  default from: "kennyandlauren@minkmeadow.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.update.subject
  #
  def ship(email,guest)
    @email = email
    mail to: guest.email, subject: email.subject, from: email.from 
  end
end
