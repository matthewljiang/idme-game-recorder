class AddFieldsToGames < ActiveRecord::Migration
  def change
    add_column :games, :p1_change, :integer, default: 0
    add_column :games, :p2_change, :integer, default: 0
  end
end
