module PostsHelper

  def post_link(post, truncate_size=0)
    if truncate_size > 0
      title = truncate(post.title, truncate_size)
    else
      title = post.title
    end
    link_to title, post.title, post_url(:id => "#{post.id}-#{h(post.title.gsub(' ','-'))}" ), :class => 'link-post'
  end

end
