class ChangeGameInstances < ActiveRecord::Miqgration

  def up
    remove_column :game_instances, :date
    add_column :game_instances, :time, :time
  end

  def down
    remove_column :game_instances, :time
    add_column :game_instances, :date, :date
  end
end
