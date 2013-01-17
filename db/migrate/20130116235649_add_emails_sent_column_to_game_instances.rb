class AddEmailsSentColumnToGameInstances < ActiveRecord::Migration

  def change
    add_column :game_instances, :emails_sent, :boolean, default: false
  end

end
