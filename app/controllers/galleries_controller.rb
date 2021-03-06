class GalleriesController < ApplicationController

  # GET /beer_votes
  # GET /
  # Via: beer_votes_path
  # Disponível: [todos]
  #
  # permite buscar um álbum
  def index
    params_search = { "order" => :descend_by_created_at }
    params_search = params_search.merge(params[:search]) if params[:search]
    @page_title = "Digite o código do álbum que quer buscar"
    @search = Comment.search(params_search)
    @comments = @search.paginate(:page => params[:page])
  end

  def search
    if(params[:id])
      redirect_to gallery_path(params[:id])
    else
      flash[:notice] = "Digite o id do álbum!"
      redirect_to galleries_path
    end
  end

  # GET /galleries/dfdsfdfdsf56rgrty
  # Via: gallery_path(dfdsfdfdsf56rgrty)
  # Disponível: [público]
  #
  # view de um álbum por um link via hash, checa id com
  # hash do album
  def show
    @gallery = Gallery.find params[:id]
    valid = true
    valid = false unless ("#{@gallery.id}-#{@gallery.gallery_hash}" == params[:id] || "#{@gallery.id}-#{@gallery.public_code}" == params[:id] )
    valid = false if "#{@gallery.id}-" == params[:id]
    render :text => "você não possui permissão!", :status => 404 unless valid
    @photos = @gallery.photos.enable.ordered
    @page_title = "Fotos do álbum #{@gallery.title}"
  end

end
