class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.integer :winner_score
      t.integer :loser_score
      t.integer :challenger_id

      t.timestamps
    end
  end
end
