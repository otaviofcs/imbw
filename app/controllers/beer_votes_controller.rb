class BeerVotesController < ApplicationController

  # Requer um +current_user+ setado.
  before_filter :user_required, :only => [:destroy]


  # GET /beer_votes
  # GET /
  # Via: beer_votes_path
  # Disponível: [todos]
  #
  # lista de beer_votes
  def index
    search_params = {"order" => :descend_by_commented_at}
    search_params = search_params.merge(params[:search]) if params[:search]
    @search = BeerVote.search(search_params)
    @beer_votes = @search.paginate :page => params[:page]
    @page_title = "Cervejas que eu bebi, hoje e ontem - I Might be W.R.O.N.G."
    @user = User.first
  end

  # DELETE /beer_votes/1
  # Via: beer_vote_path(1)
  # Disponível: [logados]
  #
  # Apaga um voto sobre cerveja
  def destroy
    @beer_vote = BeerVote.find params[:id]
    if @beer_vote.destroy
      flash[:success] = "Voto em #{@beer_vote.title} destruido com sucesso!"
    end
    redirect_to beer_votes_path
  end

end
