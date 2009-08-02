class PagesController < ApplicationController

  # GET /pages
  # GET /
  # Via: pages_path
  # Disponível: [todos]
  #
  # página index do site
  def index
    @page_title = "página inicial - home"
    @beer_votes = BeerVote.by_id.find(:all, :limit => 2)
    @comments = Comment.by_id.find(:all, :limit => 3)
    @links = Link.by_id.find(:all, :limit => 3)
    @notes = Note.by_id.find(:all, :limit => 3)
  end
end
