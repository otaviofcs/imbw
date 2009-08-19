# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Posts do IMBW"
    xml.description "imbw em feed rss"
    xml.link posts_url(:rss)

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.formatted_body(:full)
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(:id => "#{post.id}-#{h(post.title)}")
        xml.guid post_url(:id => "#{post.id}-#{h(post.title)}")
      end
    end
  end
end

