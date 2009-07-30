class GalleryCommentsController < ApplicationController

  layout false

  # GET /gallery/:gallery_id/comments
  # Via: gallery_comments_path(:gallery_id)
  # Disponível: [Usuários Normal], [Admin] # TODO autorização
  #
  # Comentários de 1 álbum
  def index

    @gallery = Gallery.find params[:gallery_id]
    @comments = @gallery.comments.all.paginate(:page => params[:page])
    @new_comment = @gallery.comments.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @gallery = Gallery.find params[:gallery_id]
    @new_comment = @gallery.comments.build(params[:comment])
    if @new_comment.save
      @success = true
    else
      @success = false
    end

    respond_to do |format|
      format.js do
        if @success
          index
          render :action => 'index'
        end
      end
    end
  end

end
