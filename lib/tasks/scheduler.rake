require "heroku"

USER = 'jacek.szlachta@gmail.com'
PASSWORD = 'junak350'
APP_NAME = 'tfmgr'

desc "Scale dynos"
task :scale, :num_of_instances do |t, args|
  heroku = Heroku::Client.new(USER, PASSWORD)
  heroku.ps_scale(APP_NAME, :type=>'web', :qty=>args[:num_of_instances])
end
