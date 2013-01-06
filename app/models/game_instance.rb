class GameInstance < ActiveRecord::Base
  attr_accessible :date, :game_definition_id, :id
end
