class ContactFormMailer < ApplicationMailer
  layout 'mailer'
  def new_contact_form(contact_form)
    @contact_form = contact_form
    mail(
      to: "stevenklavins94@gmail.com",
      subject: contact_form[:subject]
    )
  end
end