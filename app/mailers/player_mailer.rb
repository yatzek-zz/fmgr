# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun

class PlayerMailer < ActionMailer::Base
  include PlayersHelper
  default from: "noreply@fmgr.heroku.com"

  def notification_email(player, game_instance)
    #@player = player
    # TODO: click action
    # TODO: date of game
    @url  = "http://fmgr.herokuapp.com/play/#{url_safe_encode(player.id.to_s)}"
    mail(:to => player.email, :subject => "Want to play 5-a-side?")
  end

end
