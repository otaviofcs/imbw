class GalleriesController < ApplicationController

  # GET /open/galleries/dfdsfdfdsf56rgrty
  # Via: open_gallery_path(dfdsfdfdsf56rgrty)
  # Disponível: [público]
  #
  # view de um álbum por um link via hash, checa id com
  # hash do album
  def show
    @gallery = Gallery.find params[:id]
    render :text => "você não possui permissão!", :status => 404 unless "#{@gallery.id}-#{@gallery.gallery_hash}" == params[:id]
    @photos = @gallery.photos.recent
    @page_title = "Fotos do álbum #{@gallery.title}"
  end

end
