$stdout.sync = true # realtime heroku logging

require ::File.expand_path('../config/environment',  __FILE__)
run Fmgr::Application