# lib/rss_parser.rb
module RssParser

  # Parser Rss do RPLinks
  #
  # RssParser::RPLinks.run 'links.riopro.com.br',443,'https://links.riopro.com.br/rss.php/otavio', true
  class RPLinks
    require 'rexml/document'

    def self.run(host, port, url, use_ssl = false)

      xml = nil
      http = Net::HTTP.new(host, port)
      http.use_ssl = use_ssl
      http.start do |http|
          request = Net::HTTP::Get.new(url)
          response = http.request(request)
          response.value
          # turn the results into a REXML document
          xml = REXML::Document.new(response.body)
      end
      data = {
        :title    => xml.root.elements['channel/title'].text,
        :home_url => xml.root.elements['channel/link'].text,
        :rss_url  => url,
        :items    => []
      }
      xml.elements.each '//item' do |item|
        new_items = {:categories => []} and item.elements.each do |e|
          # new_items[e.name.gsub(/^dc:(\w)/,"\1").to_sym] = e.text
          new_items[e.name.to_sym] = e.text unless e.name == "category"
          new_items[:categories] << e.text if e.name == "category"
        end
        new_items[:link_source] = "rplinks"
        data[:items] << new_items
      end
      data
    end
  end


  # Parser Rss do Google Reader (que é um Atom)
  #
  # RssParser::GoogleReader.run 'www.google.com', 80, 'http://www.google.com/reader/public/atom/user/11310005898312724236/state/com.google/broadcast'
  class GoogleReader
    require 'rexml/document'
    require 'rexml/xpath'

    def self.run(host, port, url)
      use_ssl = false
      xml = nil
      http = Net::HTTP.new(host, port)
      http.use_ssl = use_ssl
      http.start do |http|
          request = Net::HTTP::Get.new(url)
          response = http.request(request)
          response.value
          # turn the results into a REXML document
          xml = REXML::Document.new(response.body)
      end
      xpath = REXML::XPath.first(xml,"//feed/")
      data = {
        :title    => '',
        :home_url => '',
        :rss_url  => url,
        :items    => []
      }
      data[:title] = xpath.elements['title'].text
      data[:home_url] = xpath.elements['link'].attributes["href"]
      REXML::XPath.each(xpath,"//feed/entry/") do |item|
        new_items = {:categories => []} and item.elements.each do |e|
          new_items[:categories] << e.attributes["term"] if e.name == "category"
        end
        new_items[:link] = item.elements['link'].attributes["href"]
        new_items[:title] = item.elements['title'].text
#        new_items[:description] = item.elements['content'].text[0..150] if item.elements['content'] && item.elements['content'].text.length > 150
#        new_items[:description] = item.elements['content'].text if item.elements['content'] && item.elements['content'].text.length <= 150
        new_items[:description] = item.elements['summary'].text[0..150] if item.elements['summary'] && item.elements['summary'].text.length > 150
        new_items[:description] = item.elements['summary'].text if item.elements['summary'] && item.elements['summary'].text.length <= 150
        new_items[:pubDate] = item.elements['published'].text
        new_items[:link_source] = "google_reader"
        data[:items] << new_items
      end
      data
    end
  end

end