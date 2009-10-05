module PostsHelper

  def post_link(post, truncate_size=0)
    if truncate_size > 0
      title = truncate(post.title, :length => truncate_size, :omission => "...")
    else
      title = post.title
    end
    link_to title, post_url(:id => "#{post.id}-#{h( post.title.gsub('.','').gsub(' ','-') )}" ), :class => 'link-post'
  end

end
