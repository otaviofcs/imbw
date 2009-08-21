# index.rss.builder
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Atividades recentes do IMBW"
    xml.description "tudo do imbw em feed rss"
    xml.link pages_url(:rss)

    for activity in @recent_activities
      xml.item do
        xml.title activity.recentable.title
        xml.description activity.recentable.text
        xml.pubDate activity.created_at.to_s(:rfc822)
        xml.link pages_url(:search => { :id_equals => activity.id })
        xml.guid pages_url(:search => { :id_equals => activity.id })
      end
    end
  end
end

