class PagesController < ApplicationController

  # GET /pages
  # GET /
  # Via: pages_path
  # Disponível: [todos]
  #
  # página index do site
  def index
    @page_title = "página inicial - home"
  end
end
