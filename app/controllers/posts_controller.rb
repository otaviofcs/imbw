class PostsController < ApplicationController

  # GET /posts
  # GET /
  # Via: posts_path
  # Via: root_path
  # Disponível: [todos]
  #
  # lista de posts
  def index
    @posts = Post.available.by_id
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
