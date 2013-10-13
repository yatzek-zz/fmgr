require 'heroku-api'

API_KEY = 'ff168fd3606f0727348d73a5a843272c523459aa'
APP_NAME = 'fmgr'

# to run: heroku run rake scale[0]
desc 'Scale dynos'
task :scale, :instances do |t, args|
  heroku = Heroku::API.new api_key: API_KEY
  heroku.post_ps_scale(APP_NAME, 'web', args[:instances])
end

desc 'create games periodic'
task :create_games => :environment do
  GameDefinition.create_games
end

desc 'send notification emails'
task :send_notification_emails => :environment do
  Game.send_notification_emails
end

desc 'send game reminders - at 15:00 on a day before the game'
task :send_game_reminders => :environment do
  Game.send_game_reminders
end