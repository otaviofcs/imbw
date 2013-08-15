module PostsHelper

  def post_link(post, truncate_size=0, css_class_name='link-post')
    if truncate_size > 0
      title = truncate(post.title, :length => truncate_size, :omission => "...")
    else
      title = post.title
    end
    link_to title, striped_post_url(post), :class => css_class_name
  end

  def striped_post_url(post)
    post_url(:id => "#{post.id}-#{h( post.title.gsub('\?','').gsub('.','').gsub('/./','-').gsub(' ','-') )}" )
  end

end
