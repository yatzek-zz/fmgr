class ChangeGameInstancesTimeColumnType < ActiveRecord::Migration

  def up
    remove_column :game_instances, :time
    add_column :game_instances, :time, :datetime
  end

  def down
    remove_column :game_instances, :time
    add_column :game_instances, :time, :time
  end
end
