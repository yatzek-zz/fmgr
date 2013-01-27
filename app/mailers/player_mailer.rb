# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun

class PlayerMailer < ActionMailer::Base
  include PlayersHelper
  default from: "noreply@fmgr.heroku.com"

  def notification_email(player, game_instance)
    @url  = subscribe_link player.id, game_instance.id
    @cancel_url = unsubscribe_link player.id, game_instance.id
    mail(:to => player.email,
         :subject => "Want to play 5-a-side on #{game_instance.time_formatted} at the Goals?")
  end

end
