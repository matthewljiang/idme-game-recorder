class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      # t.integer :elo, default: 1200
      # t.integer :weight, default: 50

      t.timestamps
    end
  end
end