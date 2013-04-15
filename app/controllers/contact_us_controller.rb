require_relative "application_controller"

class ContactUsController < ApplicationController

  def new
    @contact_form = ContactForm.new
  end

  def send_mail
    @contact_form = ContactForm.new(params[:contact_form])

    if @contact_form.valid?
      # send email?
      redirect_to root_path, :notice => "Email sent, we will get back to you"
    else
      render :new
    end
  end

end
