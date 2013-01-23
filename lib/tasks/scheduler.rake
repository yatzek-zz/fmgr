require "heroku-api"

API_KEY = 'ff168fd3606f0727348d73a5a843272c523459aa'
APP_NAME = 'fmgr'

# to run: heroku run rake scale[0]
desc "Scale dynos"
task :scale, :instances do |t, args|
  heroku = Heroku::API.new api_key: API_KEY
  heroku.post_ps_scale(APP_NAME, 'web', args[:instances])
end

desc "game instances periodic task"
task :create_game_instances => :environment do
  GameDefinition.create_game_instances
end

desc "send notification emails task"
task :send_notification_emails => :environment do
  GameInstance.send_notification_emails
end