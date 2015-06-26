class Player < ActiveRecord::Base
	before_validation :humanize_name

	validates :name, :presence => true, :uniqueness => true, :case_sensitive => false, :length => { :maximum => 15 }
	has_many :wins, :class_name => "Game", :foreign_key => "winner_id"
	has_many :lose, :class_name => "Game", :foreign_key => "loser_id"
	has_many :challenges, :class_name => "Game", :foreign_key => "challenger_id"

	def games
		wins.count + lose.count
	end

	def get_elo
		return self.elo
	end

	def update_weight
		if(games <= 15)
			self.update_attribute(:weight, 70)
		elsif(15< games and games <= 30)
			self.update_attribute(:weight, 50)
		else
			self.update_attribute(:weight, 35)
		end
	end

	def update_elo(p2_elo, result)
		p1_elo = self.elo
		change = 0
		expected_score = (1.0 + (10 ** ((p2_elo - p1_elo)/400.0))) ** -1
		change = (self.weight * (result - expected_score)).round.to_int
		p1_elo += change
		self.update_attribute(:elo, p1_elo)
		return change
	end

	def humanize_name
		self.name = self.name.to_s.humanize
	end
end