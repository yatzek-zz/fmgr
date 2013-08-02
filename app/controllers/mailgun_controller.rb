class MailgunController < ApplicationController

  def failed_hook
    MailgunHookMailer.not_delivered(params)
    logger.error "Mailgun failed delivery error, params: #{params.inspect}"
    render inline: 'OK'
  end

  #def delivered_hook
  #
  #end

end
