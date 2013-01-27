class RenamePlayerGameInstancesToPlayerGames < ActiveRecord::Migration

  def up
    rename_column :player_game_instances, :game_instance_id, :game_id
    rename_table :player_game_instances, :player_games
  end

  def down
    rename_table :player_games, :player_game_instances
    rename_column :player_game_instances, :game_id, :game_instance_id
  end
end
