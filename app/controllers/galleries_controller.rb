class GalleriesController < ApplicationController

  # GET /beer_votes
  # GET /
  # Via: beer_votes_path
  # Disponível: [todos]
  #
  # permite buscar um álbum
  def index
    @page_title = "Digite o código do álbum que quer buscar"
  end

  # GET /open/galleries/dfdsfdfdsf56rgrty
  # Via: open_gallery_path(dfdsfdfdsf56rgrty)
  # Disponível: [público]
  #
  # view de um álbum por um link via hash, checa id com
  # hash do album
  def show
    @gallery = Gallery.find params[:id]
    valid = true
    valid = false unless "#{@gallery.id}-" == params[:id]
    valid = false unless "#{@gallery.id}-#{@gallery.gallery_hash}" == params[:id]
    render :text => "você não possui permissão!", :status => 404 unless valid
    @photos = @gallery.photos.recent
    @page_title = "Fotos do álbum #{@gallery.title}"
  end

end
