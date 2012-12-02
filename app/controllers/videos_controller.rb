class VideosController < ApplicationController

  # GET /videos/1-dfdsfdfdsf56rgrty
  # Via: video_path(1-dfdsfdfdsf56rgrty)
  # Disponível: [público]
  #
  # view de um vídeo por um link via hash, checa id com
  # hash do vídeo
  def show
    @video = Video.find params[:id]
    valid = true
    valid = false unless ("#{@video.id}-#{@video.video_hash}" == params[:id] )
    valid = false if "#{@video.id}-" == params[:id]
    render :text => "você não possui permissão!", :status => 404 unless valid
    if is_mobile_device?
	@video = Video.find_by_video_hash_and_mobile @video.video_hash, true
	render :text => "não há vídeo mobile!", :status => 404 unless @video
    end
    @page_title = "Vídeo #{@video.title}"
  end
end
