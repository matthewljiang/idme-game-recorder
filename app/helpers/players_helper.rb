module PlayersHelper
  def self.reset_elo_change
    @players_items = Player.all
    @players_items.each do |p|
      p.reset_change
    end
  end
end
