Fmgr::Application.routes.draw do

  root :to => 'home#index'
  get '/games' => 'game#index'
  resources :players

  get '/playergame/subscribe/:code' => 'player_game#subscribe'
  #get '/playergame/unsubscribe/:code' => 'player_game#unsubscribe'

  post '/mailgun/failed' => 'mailgun#failed_hook'

end
