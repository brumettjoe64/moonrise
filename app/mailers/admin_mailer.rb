class AdminMailer < ActionMailer::Base
  default from: "minkmeadow@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.update.subject
  #
  def ship(email,guest)
    @email = email
    @guest = guest
    @recents = Blog.all.concat(Photo.all).sort_by{ |item| item.updated_at}.reverse[0..3]
    mail to: guest.email, subject: email.subject, from: email.from, name: email.from 
  end
end
