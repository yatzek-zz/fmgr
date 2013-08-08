class AddEmailsSentColumnToGameInstances < ActiveRecord::Migration

  def change
    add_column :game_instances, :emails_sent, :boolean
  end

end
