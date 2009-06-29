class PostsController < ApplicationController

  # GET /posts
  # GET /
  # Via: posts_path
  # Via: root_path
  # Disponível: [todos]
  #
  # lista de posts
  def index
    params_search = { :order => 'descend_by_id'}
    params_search = params_search.merge(params[:search]) unless params[:search]
    @search = Post.search params_search
    @posts = @search.available.paginate(:page => params[:page])
    @page_title = "Posts I Might be W.R.O.N.G."
  end

  # GET /posts/1
  # Via: post_path(1)
  # Disponível: [todos]
  #
  # um post
  def show
    @post = Post.find params[:id]
    @page_title = "Post ##{@post.id}"
  end
end
