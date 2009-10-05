module LinksHelper

  def link_link(link)
    link_to link.title, link_path( :id => "#{link.id}-#{h( link.title.gsub('.','').gsub(' ','-') )}")
  end

  def link_for_links(link)
    if link.description
      link_to truncate( link.description, :length => 80, :omission => "..."), link.link
    elsif link.title
      link_to truncate( link.title, :length => 80, :omission => "..."), link.link
    else
      link_to truncate(link.link, :length => 80, :omission => "..."), link.link
    end
  end

end
