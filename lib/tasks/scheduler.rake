require "heroku-api"

API_KEY = 'ff168fd3606f0727348d73a5a843272c523459aa'
APP_NAME = 'tfmgr'

# to test run: heroku run rake scale[0]
desc "Scale dynos"
task :scale, :instances do |t, args|
  heroku = Heroku::API.new api_key: API_KEY
  heroku.post_ps_scale(APP_NAME, 'web', args[:instances])
end