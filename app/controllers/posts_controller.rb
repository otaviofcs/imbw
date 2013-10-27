class PostsController < ApplicationController

  # GET /posts
  # Via: posts_path
  # Disponível: [todos]
  #
  # lista de posts
  def index
    params_search = { "order" => 'descend_by_published_at'}
    params_search = params_search.merge(params[:search]) if params[:search]
    @search = Post.available.search params_search
    @posts = @search.paginate(:page => params[:page])
    @page_title = "Posts I Might be W.R.O.N.G."
    @tags = Post.tag_counts :limit => 80
  end

  # GET /posts/1
  # Via: post_path(1)
  # Disponível: [todos]
  #
  # um post
  def show
    @post = Post.find params[:id]
    @page_title = "Post ##{@post.id}-#{@post.title}"
    @related_posts = []
    @post.tag_list.each do |one_tag|
      @related_posts.concat Post.search(:id_not_equal_to => @post.id, :order => 'descend_by_published_at').tagged_with_on_tags(one_tag).all
    end
    @related_posts.uniq!
  end
end
