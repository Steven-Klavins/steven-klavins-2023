class NotificationMailer < ApplicationMailer
  layout 'mailer'
  def new_notification(subject, notification)
    @notification = notification
    mail(
      to: "stevenklavins94@gmail.com",
      subject: subject
    )
  end
end