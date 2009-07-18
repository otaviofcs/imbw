class PhotosController < ApplicationController

  # GET /photos/1-dfdsfdfdsf56rgrty
  # Via: photo_path(:id => '1-dfdsfdfdsf56rgrty')
  # Disponível: [público]
  #
  # view de uma imagem por um link via hash, checa id com
  # hash do album
  def show
    @photo = Photo.find params[:id]
    valid = true
    valid = false unless "#{@photo.id}-#{@photo.photo_hash}" == params[:id]
    valid = false if "#{@photo.id}-" == params[:id]
    render :text => "Não, você não possui permissão!", :status => 404 unless valid
    @page_title = "Foto #{@photo.title}"
  end

end
