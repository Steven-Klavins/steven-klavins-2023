class ContactFormController < ApplicationController
  def create
    @name = params[:contact_form][:name]
    @subject = params[:contact_form][:subject]
    @email = params[:contact_form][:email]
    @message = params[:contact_form][:message]

    redirect_to :root
  end
end