# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun

class PlayerMailer < ActionMailer::Base
  include PlayersHelper
  default from: "noreply@fmgr.heroku.com"

  def notification_email(player, game)
    @url  = subscribe_link player.id, game.id
    @cancel_url = unsubscribe_link player.id, game.id
    mail(:to => player.email,
         :subject => "Want to play 5-a-side on #{game.time_formatted} at the Goals?")
  end

end
