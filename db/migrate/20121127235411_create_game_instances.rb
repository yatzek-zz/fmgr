class CreateGameInstances < ActiveRecord::Migration

  def change
    create_table :game_instances do |t|
      t.primary_key :id
      t.integer :game_definition_id
      t.datetime :time

      t.timestamps
    end
  end

end
