class PlayersController < ApplicationController
  def index
    @players_items = Player.all.sort{|y,x| x.get_elo() <=> y.get_elo()}
  end

  # def new
  #   @player = Player.new(params[:name].to_s.humanize)
  # end

  def create
    @player = Player.new(player_params)
    # @player = Player.create(params[:player])
  	# @player = Player.create(:name => params[:name].to_s.humanize, :elo_change => 0)

    if @player.save
      flash[:notice] = "Player " + player_params[:name].to_s.humanize + " added"
      redirect_to root_path
    else
      redirect_to root_path, notice: "Oops, try again. Errors: #{@player.errors.full_messages}"
    end
  end

  def show
  	@player = Player.find(params[:id])
  	@wins = @player.wins
  	@losses = @player.lose
  	@player_games = @wins + @losses
  end

  private 

    def player_params
      params.require(:player).permit(:name)
    end
end
