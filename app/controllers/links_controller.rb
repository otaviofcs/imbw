class LinksController < ApplicationController

  # GET /posts
  # GET /
  # Via: links_path
  # Disponivel: [todos]
  #
  # lista de links
  def index
    @search = Link.search params[:search]
    @links = @search.paginate(:page => params[:page])
    @page_title = "O que estou lendo"
    @tags = Link.tag_counts :limit => 10
  end


end
