# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun

class MailgunHookMailer < ActionMailer::Base

  default from: 'noreply@fmgr.heroku.com'

  def not_delivered(params)
    @params = params
    mail(:to => 'jacek.szlachta@gmail.com', :subject => 'Email not delivered mailgun hook')
  end

end
