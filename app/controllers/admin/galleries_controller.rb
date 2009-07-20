class Admin::GalleriesController < AdminController

  # GET /admin/galleries
  # Via: admin_galleries_path
  # Disponível: [admin]
  #
  # lista de álbuns
  def index
    @galleries = Gallery.recent
    @page_title = "Álbuns"
  end

  # GET /admin/galleries/1
  # Via: admin_gallery_path(1)
  # Disponível: [admin]
  #
  # view de um álbum
  def show
    @gallery = Gallery.find params[:id]
    @photos = @gallery.photos.by_id
    @page_title = "Fotos do álbum #{@gallery.title}"
  end

  # GET /admin/galleries/new
  # Via: new_admin_galleries_path
  # Disponível: [admin]
  #
  # novo gallery
  def new
    @gallery = Gallery.new
    @page_title = "Novo Álbum"
  end

  # GET /admin/galleries/1/edit
  # Via: edit_admin_galleries_path(1)
  # Disponível: [admin]
  #
  # editando gallery
  def edit
    @gallery = Gallery.find params[:id]
    @page_title = "Editando Álbum ##{@gallery.id}"
  end

  # POST /admin/galleries
  # Via: admin_gallery_path
  # Available: [administradores]
  #
  # Criar novo usuário
  def create
    @gallery = current_user.galleries.new(params[:gallery])
    if @gallery.save
      flash[:success] = "Álbum criado com sucesso."
      redirect_to admin_galleries_path
    else
      @page_title = "Novo Álbum"
      render :action => 'new'
    end
  end

  # PUT /admin/galleries/1
  # Via: admin_galleries_path
  # Disponível: [admin]
  #
  # Atualiza dados do usuário
  def update
    @gallery = Gallery.find params[:id]
    if @gallery.update_attributes(params[:gallery])
      flash[:success] = "Álbum alterado com sucesso"
      redirect_to admin_galleries_path
    else
      @page_title = "Editando Álbum ##{@gallery.id}"
      render :action => 'edit'
    end
  end

  # DELETE /admin/galleries/1
  # Via: admin_gallery_path(1)
  # Disponível: [admin]
  #
  # apaga usuário
  def destroy
    @gallery = Gallery.find params[:id]
    @gallery.destroy
    flash[:success] = "Álbum apagado com sucesso"
    redirect_to admin_galleries_path
  end

end
