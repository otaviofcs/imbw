class GalleryCommentsController < ApplicationController

  layout false

  # GET /gallery/:gallery_id/comments
  # Via: gallery_comments_path(:gallery_id)
  # Disponível: [Usuários Normal], [Admin] # TODO autorização
  #
  # Comentários de 1 álbum
  def index
    load_variables
    @new_comment = @gallery.comments.new
    is_valid
    respond_to do |format|
      format.js
    end
  end

  def create
    load_variables
    @new_comment = @gallery.comments.new
    is_valid
    @new_comment = @gallery.comments.build(params[:comment]) if @valid

    if @new_comment.save
      @success = true
    else
      @success = false
    end

    respond_to do |format|
      format.js do
        if @success
          render :action => 'index'
        end
      end
    end
  end

  protected

    def load_variables
      @search_params =  { "order" => 'ascend_by_created_at'}
      @search_params = @search_params.merge(params[:search]) if params[:search]
      @gallery = Gallery.find params[:gallery_id]
      @search = @gallery.comments.search(@search_params)
      @comments = @search.paginate(:page => params[:page])
    end

    def is_valid
      @valid = true
      @valid = false unless ("#{@gallery.id}-#{@gallery.gallery_hash}" == params[:id] || "#{@gallery.id}-#{@gallery.public_code}" == params[:id] )
      @valid = false if "#{@gallery.id}-" == params[:id]
    end
end
