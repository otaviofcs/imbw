class BeerVotesController < ApplicationController

  # GET /beer_votes
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

  # GET /beer_votes/1
  # Via: beer_vote_path(1)
  # Disponível: [todos]
  #
  # um voto
  def show
    @beer_vote = BeerVote.find(params[:id])
    @page_title = "Cervejas #{@beer_vote.title} - I Might be W.R.O.N.G."
    @user = User.first
  end

end
