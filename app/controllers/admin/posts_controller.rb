class Admin::PostsController < AdminController

  # GET /admin/posts
  # Via: admin_posts_path
  # Disponível: [admin]
  #
  # lista de posts
  def index
    @posts = Post.by_id.paginate( :page => params[:page] )
    @page_title = "Lista de Posts"
  end

  # GET /admin/posts/new
  # Via: new_admin_posts_path
  # Disponível: [admin]
  #
  # novo post
  def new
    @post = Post.new
    @page_title = "Novo Post"
  end

  # GET /admin/posts/1/edit
  # Via: edit_admin_posts_path(1)
  # Disponível: [admin]
  #
  # editando post
  def edit
    @post = Post.find params[:id]
    @page_title = "Editando Post ##{@post.id}"
  end

  # POST /admin/posts/preview
  # Via: preview_admin_posts_path
  # Available: [administradores]
  #
  # Preview de um post
  def preview
    @post = current_user.posts.build(params[:post])
    respond_to do |format|
      format.js
    end
  end

  # POST /admin/posts
  # Via: admin_posts_path
  # Available: [administradores]
  #
  # Criar novo post
  def create
    @post = current_user.posts.new(params[:post])
    @post.edited_at = Time.current
    @post.published_at = Time.current if params[:publish]
    if @post.save
      flash[:success] = "Post criado com sucesso."
      redirect_to admin_posts_path
    else
      @page_title = "Novo Post"
      render :action => 'new'
    end
  end

  # PUT /admin/posts/1
  # Via: admin_posts_path
  # Disponível: [admin]
  #
  # Atualiza dados do post
  def update
    @post = current_user.posts.find params[:id]
    @post.edited_at = Time.current
    @post.published_at = Time.current if params[:publish]
    valid = @post.update_attributes(params[:post])
    respond_to do |format|
      format.js
      format.any do
        if valid
          flash[:success] = "Post alterado com sucesso"
          redirect_to admin_posts_path
        else
          @page_title = "Editando Post ##{@post.id}"
          render :action => 'edit'
        end
      end      
    end
  end

  # DELETE /admin/posts/1
  # Via: admin_post_path(1)
  # Disponível: [admin]
  #
  # excluindo post
  def destroy
    @post = Post.find params[:id]
    @post.destroy
    @page_title = "Post excluído com sucesso"
    flash[:success] = "Post excluído com sucesso"
    redirect_to admin_posts_path
  end

end
