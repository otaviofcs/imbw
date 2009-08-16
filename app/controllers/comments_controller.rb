class CommentsController < ApplicationController

  # GET /comments
  # Via: comments_path
  # Disponível: [Usuários Normal], [Admin] # TODO autorização
  #
  # Comentários de todos os álbuns
  def index
    params_search = { "order" => 'descend_by_id'}
    params_search = params_search.merge(params[:searchlogic_search]) if params[:searchlogic_search]
    @search = Comment.search params_search
    @comments = @search.paginate(:page => params[:page])
    respond_to do |format|
      format.js
    end
  end

end
