class BeerVotesController < ApplicationController


  # GET /beer_votes
  # GET /
  # Via: beer_votes_path
  # Disponível: [todos]
  #
  # lista de beer_votes
  def index
    @beer_votes = BeerVote.last_commented_at
    @page_title = "Cervejas que eu bebi, hoje e ontem - I Might be W.R.O.N.G."
    @user = User.first
  end

end
