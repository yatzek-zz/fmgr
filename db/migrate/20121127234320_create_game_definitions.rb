class CreateGameDefinitions < ActiveRecord::Migration

  def change
    create_table :game_definitions do |t|
      t.string :day
      t.string :time

      t.timestamps
    end
  end

end
