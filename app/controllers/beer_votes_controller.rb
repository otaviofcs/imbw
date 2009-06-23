class BeerVotesController < ApplicationController


  # GET /beer_votes
  # GET /
  # Via: beer_votes_path
  # Disponível: [todos]
  #
  # lista de beer_votes
  def index
    @beer_votes = BeerVote.by_id
    @page_title = "Cervejas que eu bebi, hoje e ontem - I Might be W.R.O.N.G."
  end

end
