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
  end

end
