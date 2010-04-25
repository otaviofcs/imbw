class VideoCommentsController < ApplicationController

  layout false

  # GET /video/:video_id/comments
  # Via: video_comments_path(:video_id)
  # Disponível: [Usuários Normal], [Admin] # TODO autorização
  #
  # Comentários de 1 vídeo
  def index
    @video = Video.find params[:video_id]
    load_variables
    @new_comment = @video.comments.new
    valid_video
  end

  def create
    @video = Video.find params[:video_id]
    @new_comment = @video.comments.new
    valid_video
    @new_comment = @video.comments.build(params[:comment]) if @valid

    if @new_comment.save
      load_variables
      @new_comment = @video.comments.new
      @success = true
    else
      @success = false
    end

    if @success
      render :action => 'index'
    end
  end

  protected

    def load_variables
      @search_params =  { "order" => 'descend_by_created_at'}
      @search_params = @search_params.merge(params[:search]) if params[:search]
      @search = @video.comments.search(@search_params)
      @comments = @search.paginate(:page => params[:page])
    end

    def valid_video
      @valid = true
      @valid = false unless ("#{@video.id}-#{@video.video_hash}" == params[:video_id] || "#{@video.id}-#{@video.public_code}" == params[:video_id] )
      @valid = false if "#{@video.id}-" == params[:video_id]
    end
end
