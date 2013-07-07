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

  attr_accessible :player_id, :game_id

  belongs_to :player
  belongs_to :game

  validates :player_id, :presence => true
  validates :game_id, :presence => true
  validates :player_id, :uniqueness => {:scope => :game_id}

  def self.create_if_not_exists(player_id, game_id)
    unless PlayerGame.exists?(player_id: player_id, game_id: game_id)
      PlayerGame.new(player_id: player_id, game_id: game_id).save
    end
  end

  def self.delete_if_exists(player_id, game_id)
    if PlayerGame.exists?(player_id: player_id, game_id: game_id)
      PlayerGame.where(player_id: player_id, game_id: game_id).delete_all
    end
  end

end
