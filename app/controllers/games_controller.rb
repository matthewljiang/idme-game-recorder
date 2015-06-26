class GamesController < ApplicationController
  def archive
    @games_items = Game.all.paginate(:page => params[:page], per_page: 14)
  end
  
  def index
  	@games_items = Game.all
  end 

  def create
    @game = Game.new(game_params)
    # @game = Game.create(:winner_id => params[:p1_id], :loser_id => params[:p2_id], 
      # :winner_score => params[:wscore], :loser_score => params[:lscore], 
      # :challenger_id => params[:ch_id])

    if @game.save
      @p1 = Player.find(game_params[:winner_id])
      @p2 = Player.find(game_params[:loser_id])
      p1_temp_elo = @p1.get_elo()
      p2_temp_elo = @p2.get_elo()
      @p1.update_weight()
      @p2.update_weight()
      p1_change = @p1.update_elo(p2_temp_elo, 1)
      @p1.update_change(p1_change)
      p2_change = @p2.update_elo(p1_temp_elo, 0)
      @p2.update_change(p2_change)
      @game.update_attribute(:p1_change, p1_change)
      @game.update_attribute(:p2_change, p2_change)
      flash[:notice] = "Game added"
      redirect_to games_path
    else
      redirect_to games_path, :notice => "Oops, try again. Errors: #{@game.errors.full_messages}"
    end
  end


  # def add
  #   p1 = Player.find(params[:p1_id])
  #   p2 = Player.find(params[:p2_id])
  #   p1_temp_elo = p1.get_elo()
  #   p2_temp_elo = p2.get_elo()
  #   p1.update_weight()
  #   p2.update_weight()
  #   p1_change = p1.update_elo(p2_temp_elo, 1)
  #   p1.update_change(p1_change)
  #   p2_change = p2.update_elo(p1_temp_elo, 0)
  #   p2.update_change(p2_change)
  #   Game.create(:winner_id => params[:p1_id], :loser_id => params[:p2_id], 
  #     :winner_score => params[:wscore], :loser_score => params[:lscore], 
  #     :challenger_id => params[:ch_id], :p1_change => p1_change, :p2_change => p2_change)
  #   flash[:notice] = "Game added"
  #   redirect_to :action => 'index'
  # end

  def destroy
    @game = Game.find(params[:id])
  	p1 = Player.find(@game.winner_id)
    p2 = Player.find(@game.loser_id)
    p1.update_attribute(:elo, p1.get_elo() - @game.p1_change)
    p1.update_change(-1 * @game.p1_change)
    p2.update_attribute(:elo, p2.get_elo() - @game.p2_change)
    p2.update_change(-1 * @game.p2_change)
    @game.destroy()
    flash[:notice] = "Game deleted"
  	redirect_to :action => 'index'
  end

  private 

    def game_params
      params.require(:game).permit(:winner_id, :loser_id, :winner_score, :loser_score, :challenger_id)
    end
end
