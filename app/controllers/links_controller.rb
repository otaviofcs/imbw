class LinksController < ApplicationController

  # GET /links
  # Via: links_path
  # Disponivel: [todos]
  #
  # lista de links
  def index
    params_search = { "order" => :descend_linked_at }
    params_search = params_search.merge(params[:search]) if params[:search]
    @search = Link.search params_search
    @links = @search.paginate(:page => params[:page])
    @page_title = "O que estou lendo"
    @tags = Link.tag_counts :limit => 10
  end


end
