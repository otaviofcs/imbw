# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Atividades recentes do IMBW"
    xml.description "tudo do imbw em feed rss"
    xml.link pages_url(:rss)

    for activity in @recent_activities
      xml.item do
        xml.title activity.title
        xml.description activity.formatted_body(:full)
        xml.pubDate activity.created_at.to_s(:rfc822)
        xml.link post_url(:id => "#{post.id}-#{h(post.title)}")
        xml.guid post_url(:id => "#{post.id}-#{h(post.title)}")
      end
    end
  end
end

