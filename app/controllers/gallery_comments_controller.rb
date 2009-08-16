class GalleryCommentsController < ApplicationController

  layout false

  # GET /gallery/:gallery_id/comments
  # Via: gallery_comments_path(:gallery_id)
  # Disponível: [Usuários Normal], [Admin] # TODO autorização
  #
  # Comentários de 1 álbum
  def index
    @gallery = Gallery.find params[:gallery_id]
    load_variables
    @new_comment = @gallery.comments.new
    valid_gallery
    respond_to do |format|
      format.js
    end
  end

  def create
    @gallery = Gallery.find params[:gallery_id]
    @new_comment = @gallery.comments.new
    valid_gallery
    @new_comment = @gallery.comments.build(params[:comment]) if @valid

    if @new_comment.save
      load_variables
      @new_comment = @gallery.comments.new
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
      @search_params =  { "order" => 'descend_by_created_at'}
      @search_params = @search_params.merge(params[:search]) if params[:search]
      @search = @gallery.comments.search(@search_params)
      @comments = @search.paginate(:page => params[:page])
    end

    def valid_gallery
      @valid = true
      @valid = false unless ("#{@gallery.id}-#{@gallery.gallery_hash}" == params[:gallery_id] || "#{@gallery.id}-#{@gallery.public_code}" == params[:gallery_id] )
      @valid = false if "#{@gallery.id}-" == params[:gallery_id]
    end
end
