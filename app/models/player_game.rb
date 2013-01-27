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

end
