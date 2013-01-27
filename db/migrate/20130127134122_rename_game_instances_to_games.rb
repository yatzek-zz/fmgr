class RenameGameInstancesToGames < ActiveRecord::Migration
  def up
    rename_table :game_instances, :games
  end

  def down
    rename_table :games, :game_instances
  end
end
