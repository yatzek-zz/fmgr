class MailgunController < ApplicationController

  def failed_hook
    MailgunHookMailer.not_delivered(params).deliver
    logger.error "Mailgun failed delivery error, params: #{params.inspect}"
    render inline: 'OK'
  end

end
