class AddEloChangeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :elo_change, :integer, default: 0
  end
end
