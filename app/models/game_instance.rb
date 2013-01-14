class GameInstance < ActiveRecord::Base
  attr_accessible :time, :game_definition
  validates :time, :game_definition, :presence => true

  validates :time, :uniqueness => {:scope => :game_definition_id }

  belongs_to :game_definition
end
