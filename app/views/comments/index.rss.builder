# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Comentários do imbw"
    xml.description "comentários dos álbuns imbw em feed rss"
    xml.link comments_url(:rss)

    for comment in @comments
      xml.item do
        xml.title "#{comment.name} comentou"
        xml.description comment.comment
        xml.pubDate comment.created_at.to_s(:rfc822)
        xml.link comment_url(comment)
        xml.guid comment_url(comment)
      end
    end
  end
end

