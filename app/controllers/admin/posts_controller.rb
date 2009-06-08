class Admin::PostsController < AdminController

  # GET /admin/posts
  # Via: admin_posts_path
  # Disponível: [admin]
  #
  # lista de posts
  def index
    @posts = Post.by_id
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


  # DELETE /admin/posts/1
  # Via: admin_post_path(1)
  # Disponível: [admin]
  #
  # excluindo post
  def destroy
    @post = Post.find params[:id]
    @post.destroy
    @page_title = "Post excluído com sucesso"
    redirect_to admin_posts_path
  end

end
