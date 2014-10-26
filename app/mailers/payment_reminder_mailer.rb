# heroku mailer settings, copied from: https://devcenter.heroku.com/articles/mailgun

class PaymentReminderMailer < ActionMailer::Base

  default from: 'noreply@fmgr.heroku.com'

  def payment_reminder_email(player, game, price)
    @price = price
    mail(:to => player.email,
         :subject => "Footie payment reminder - game on #{game.time_formatted}")
  end

end
