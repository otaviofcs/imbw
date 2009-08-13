class PostsController < ApplicationController

  # GET /posts
  # Via: posts_path
  # Disponível: [todos]
  #
  # lista de posts
  def index
    params_search = { "order" => 'descend_by_id'}
    params_search = params_search.merge(params[:search]) if params[:search]
    @search = Post.available.search params_search
    @posts = @search.paginate(:page => params[:page])
    @page_title = "Posts I Might be W.R.O.N.G."
    @tags = Post.tag_counts :limit => 10
  end

  # GET /posts/1
  # Via: post_path(1)
  # Disponível: [todos]
  #
  # um post
  def show
    @post = Post.find params[:id]
    @page_title = "Post ##{@post.id}-#{@post.title}"
  end
end
