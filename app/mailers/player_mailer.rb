# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun
ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'],
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => 'fmgr.heroku.com',
    :authentication => :plain,
}
ActionMailer::Base.delivery_method = :smtp

class PlayerMailer < ActionMailer::Base
  include PlayersHelper
  default from: "noreply@fmgr.heroku.com"

  def notification_email(player)
    #@player = player
    # TODO: click action
    @url  = "http://fmgr.herokuapp.com/play/#{url_safe_encode(player.id.to_s)}"
    mail(:to => player.email, :subject => "Want to play 5-a-side on Tuesday?")
  end

end
