# == Schema Information
#
# Table name: player_games
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlayerGame < ActiveRecord::Base

  belongs_to :player
  belongs_to :game

  validates :player_id, :presence => true
  validates :game_id, :presence => true
  validates :player_id, :uniqueness => {:scope => :game_id}

  class << self

    def create_if_not_exists(player_id, game_id)
      unless PlayerGame.exists?(player_id: player_id, game_id: game_id)
        PlayerGame.new(player_id: player_id, game_id: game_id).save
      end
    end

    def delete_if_exists(player_id, game_id)
      if PlayerGame.exists?(player_id: player_id, game_id: game_id)
        PlayerGame.where(player_id: player_id, game_id: game_id).delete_all
      end
    end

    MAX_5_A_SIDE = 10
    MIN_7_A_SIDE = 12
    MAX_7_A_SIDE = 14

    def is_reserve_player?(index, all_players)
      num = index + 1

      case num
        when 1..MAX_5_A_SIDE
          false
        when 11
          !(all_players >= MIN_7_A_SIDE)
        when 12
          false
        when 13
          !(all_players >= MAX_7_A_SIDE)
        when 14
          false
        else
          true
      end

    end

  end

end
