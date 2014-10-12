Fmgr::Application.routes.draw do

  root :to => 'home#index'
  get '/games' => 'game#index'
  resources :players

  get '/playergame/subscribe/:code' => 'player_game#subscribe'
  delete '/playergame/delete/:game_id/:player_id' => 'player_game#remove_player'
  #get '/playergame/unsubscribe/:code' => 'player_game#unsubscribe'

  post '/mailgun/failed' => 'mailgun#failed_hook'

end
