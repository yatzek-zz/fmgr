class AddDisabledFlagToGameDefinition < ActiveRecord::Migration
  def change
    add_column :game_definitions, :disabled, :boolean
  end
end
