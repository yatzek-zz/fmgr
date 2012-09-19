require "heroku-api"

API_KEY = 'ff168fd3606f0727348d73a5a843272c523459aa'
APP_NAME = 'tfmgr'

# to test run: heroku run rake scale[0]
desc "Scale dynos"
task :scale, :instances do |t, args|
  heroku = Heroku::API.new api_key: API_KEY
  heroku.post_ps_scale(APP_NAME, 'web', args[:instances])
end


desc "send notification emails testing task"
task :send_notifications => :environment do
  controller = PlayersController.new
  controller.send_notification_emails
end

desc "send notification emails on thursday task"
task :send_emails_on_thursday => :environment do
  if Time.now.thursday?
    controller = PlayersController.new
    controller.send_notification_emails
  end
end

desc "test encryptor gem"
require "encryptor"
require "base64"
Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('very secret'))
task :test_encryption => :environment do
  enc = "test string".encrypt
  puts Base64.urlsafe_encode64 enc
  puts enc
  puts enc.decrypt
end