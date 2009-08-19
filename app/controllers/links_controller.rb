class LinksController < ApplicationController

  # Requer um +current_user+ setado.
  before_filter :user_required, :only => [:destroy]

  # GET /links
  # Via: links_path
  # Disponivel: [todos]
  #
  # lista de links
  def index
    params_search = { "order" => :descend_by_linked_at }
    params_search = params_search.merge(params[:search]) if params[:search]
    @search = Link.search params_search
    @links = @search.paginate(:page => params[:page])
    @page_title = "O que estou lendo"
    @tags = Link.tag_counts :limit => 10
  end

  # DELETE /links/1
  # Via: link_path(1)
  # Disponível: [logados]
  #
  # Apaga um link
  def destroy
    @link = Link.find params[:id]
    if @link.destroy
      flash[:success] = "#{@link.title} destruido com sucesso!"
    end
    redirect_to links_path
  end

end
