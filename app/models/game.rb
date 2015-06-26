class Game < ActiveRecord::Base
  validate :challenger_played_in_game, :unique_players
  validates :winner, :presence => true
  validates :loser, :presence => true
  validates :winner_score, :numericality => { :greater_than_or_equal_to => 0 }
  validates :loser_score, :numericality=> { :greater_than_or_equal_to => 0 }
	belongs_to :winner, :class_name => "Player"
	belongs_to :loser, :class_name => "Player"
	belongs_to :challenger, :class_name => "Player"

  def challenger_played_in_game
    if(self.winner_id != self.challenger_id and self.loser_id != self.challenger_id)
        errors.add(:challenger_id, "must have played in game")
    end
  end

  def unique_players
    if(self.winner_id == self.loser_id)
      errors.add(:base, "Player cannot play themselves")
    end
  end

  default_scope order("games.created_at DESC")
end