class ContactFormController < ApplicationController
  def create
    ContactFormMailer.new_contact_form(contact_form_params).deliver_later
    redirect_to thanks_path
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :subject, :email, :message)
  end
end

