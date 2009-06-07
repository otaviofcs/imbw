class Admin::PostsController < AdminController

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



end
