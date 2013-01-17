class GameInstance < ActiveRecord::Base
  attr_accessible :time, :game_definition, :emails_sent
  validates :time, :game_definition, :presence => true

  validates :time, :uniqueness => {:scope => :game_definition_id }

  belongs_to :game_definition

  has_many :player_game_instances
  has_many :players, :through => :player_game_instances
end
