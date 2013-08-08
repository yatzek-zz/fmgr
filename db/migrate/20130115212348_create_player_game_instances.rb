class CreatePlayerGameInstances < ActiveRecord::Migration
  def change
    create_table :player_game_instances do |t|
      t.integer :player_id
      t.integer :game_instance_id

      t.timestamps
    end
  end
end
