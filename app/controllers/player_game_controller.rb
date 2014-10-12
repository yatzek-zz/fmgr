require_relative 'application_controller'

class PlayerGameController < ApplicationController

  def subscribe
    player_id, game_id = decode_ids(params)

    PlayerGame.create_if_not_exists(player_id, game_id)
    player_game_details(game_id, player_id)
  end

  def unsubscribe
    player_id, game_id = decode_ids(params)

    PlayerGame.delete_if_exists(player_id, game_id)
    player_game_details(game_id, player_id)
  end

  def remove_player
    player_id, game_id = params[:player_id], params[:game_id]

    PlayerGame.delete_if_exists(player_id, game_id)
    player_game_details(game_id, player_id)
  end

  :private

  def decode_ids(params)
    hash = LinkUtils.url_decode(params[:code])
    LinkUtils.decrypt_link_hash(hash)
  end

  def player_game_details(game_id, player_id)
    @game = Game.find(game_id)
    @player = Player.find(player_id)
  end

end
