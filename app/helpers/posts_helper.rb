module PostsHelper

  def post_link(post, truncate_size=0)
    if truncate_size > 0
      title = truncate(post.title, :length => truncate_size, :omission => "...")
    else
      title = post.title
    end
    link_to title, striped_post_url(post), :class => 'link-post'
  end

  def striped_post_url(post)
    post_url(:id => "#{post.id}-#{h( post.title.gsub('.','').gsub(' ','-') )}" )
  end

end
