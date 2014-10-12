module ViewHelper

  def player_class_for_index(index, all_players)
    PlayerGame.is_reserve_player?(index, all_players) ? 'reserve-player' : 'base-player'
  end

end