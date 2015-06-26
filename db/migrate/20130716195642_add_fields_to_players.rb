class AddFieldsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :elo, :integer, default: 1200
    add_column :players, :weight, :integer, default: 50
  end
end
