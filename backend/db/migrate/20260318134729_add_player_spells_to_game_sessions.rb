class AddPlayerSpellsToGameSessions < ActiveRecord::Migration[8.1]
  def change
    add_column :game_sessions, :player_spells, :string, array: true, default: []
  end
end
