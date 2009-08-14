class Admin::GalleryPhotosController < AdminController

  before_filter :load_gallery

  # GET /admin/gallery/all/photos
  # Via: admin_gallery_photos_path(:gallery_id => :all)
  # Disponível: [admin]
  #
  # lista de fotos em geral
  def index
    @photos = Photo.recent.paginate(:page => params[:page])
    @page_title = "todas as fotos"
  end

  # GET /admin/gallery/1/photos/new
  # Via: new_admin_gallery_photo_path
  # Disponível: [admin]
  #
  # nova foto para o álbum
  def new
    @photo = @gallery.photos.new
    @page_title = "Nova Foto do álbum"
  end

  # POST /admin/galleries/1/photos
  # Via: admin_gallery_photos_path
  # Available: [administradores]
  #
  # Criar nova foto
  def create
    @photo = @gallery.photos.new(params[:photo])
    if @photo.save
      flash[:success] = "Foto #{@photo.filename} do álbum criada com sucesso. Envie outra se quiser."
      redirect_to new_admin_gallery_photo_path(@gallery)
    else
      @page_title = "Novo Foto do álbum"
      render :action => 'new'
    end
  end

  # GET /admin/galleries/1/photos/2/edit
  # Via: edit_admin_gallery_photo_path(1,2)
  # Disponível: [admin]
  #
  # editando foto da galleria
  def edit
    @photo = @gallery.photos.find params[:id]
    @page_title = "Editando Foto ##{@gallery.id}"
  end

  # PUT /admin/galleries/1/photos/2
  # Via: admin_gallery_photo_path(1)
  # Disponível: [admin]
  #
  # Atualiza dados do usuário
  def update
    @photo = @gallery.photos.find params[:id]
    if @photo.update_attributes(params[:photo])
      flash[:success] = "Foto atualizada com sucesso"
      redirect_to admin_gallery_path(@gallery)
    else
      @page_title = "Editando Foto ##{@photo.id}"
      render :action => 'edit'
    end
  end

  # DELETE /admin/galleries/1
  # Via: admin_gallery_photos_path(1)
  # Disponível: [admin]
  #
  # apaga álbum inteiro e todas as fotos e comentários
  def destroy
    @photo = @gallery.photos.find params[:id]
    @photo.destroy
    flash[:success] = "Foto do álbum apagado com sucesso"
    redirect_to admin_gallery_path(@gallery)
  end

  protected

    def load_gallery
     @gallery = Gallery.find params[:gallery_id]
    end

end
