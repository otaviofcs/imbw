class GalleryCommentsController < ApplicationController


  # GET /gallery/:gallery_id/comments
  # Via: gallery_comments_path(:gallery_id)
  # Disponível: [Usuários Normal], [Admin] # TODO autorização
  #
  # Comentários de 1 álbum
  def index

    @gallery = Gallery.find params[:gallery_id]
    @comments = @gallery.comments.all.paginate(:page => params[:page])

    respond_to do |format|
      format.js
    end
  end

end
