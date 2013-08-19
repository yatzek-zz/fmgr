module ViewHelper

  def player_class_for_index(index)
    index > 9 ? 'reserve-player' : 'base-player'
  end

end