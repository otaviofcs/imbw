class BeerVotesController < ApplicationController


  # GET /beer_votes
  # GET /
  # Via: beer_votes_path
  # Disponível: [todos]
  #
  # lista de beer_votes
  def index
    search_params = {:order => :ascend_by_commented_at}
    search_params = search_params.merge(params[:search]) if params[:search]
    @search = BeerVote.search(search_params)
    @beer_votes = @search.paginate :page => params[:page]
    @page_title = "Cervejas que eu bebi, hoje e ontem - I Might be W.R.O.N.G."
    @user = User.first
  end

end
