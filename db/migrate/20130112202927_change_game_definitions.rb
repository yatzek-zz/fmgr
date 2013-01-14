class ChangeGameDefinitions < ActiveRecord::Migration

  def up
    change_column :game_definitions, :time, :string
  end

  def down
    change_column :game_definitions, :time, :time
  end

end
