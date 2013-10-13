# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun

class GameReminderMailer < ActionMailer::Base

  default from: 'noreply@fmgr.heroku.com'

  def reminder_email(player, game)
    mail(:to => player.email,
         :subject => "Footie reminder - game on #{game.time_formatted} at the Goals")
  end

end
