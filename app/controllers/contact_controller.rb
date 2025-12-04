class ContactController < ApplicationController

  def index
    @contact_form = ContactForm.new
  end

  def submit_contact_form
    @contact_form = ContactForm.new(contact_form_params)

    if @contact_form.valid?
      ContactFormMailer.new_contact_form(contact_form_params).deliver_later
      redirect_to thanks_path
    else
      flash.now[:alert] = "Please fill in all required fields."
      render :index
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :subject, :email, :message)
  end
end

