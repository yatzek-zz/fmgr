require "chronic"

class GameDefinition < ActiveRecord::Base

  attr_accessible :day, :time
  validates :day, :time, :presence => true
  validates :time, :uniqueness => {:scope => :day }

  def next_game_time
    Chronic.parse "next #{day} #{time}"
  end

  CREATE_GAME_BEFORE_DAYS = 5 * 24 * 60 * 60

  # game instance creation
  # run daily
  def self.create_game_instances
    game_definitions = GameDefinition.all
    game_definitions.each do |game_definition|

      now = Time.now
      next_game_time = game_definition.next_game_time

      # if less than 5 days to the next game
      if now + CREATE_GAME_BEFORE_DAYS > next_game_time

        game_instance = GameInstance.last(conditions: "game_definition_id = #{game_definition.id}")
        # if next game instance does not exist yet
        unless game_instance && game_instance.time == next_game_time
          GameInstance.create(game_definition: game_definition, time: game_definition.next_game_time)
          # TODO: send emails here???
        end

      end

    end
  end


end
