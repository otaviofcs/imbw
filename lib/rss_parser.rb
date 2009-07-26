module RssParser

  class WithUri
    require 'rss/2.0'
    require 'open-uri'

    # feed_url = 'http://www.planetrubyonrails.org/xml/rss'
    def self.parse_rss_feed(feed_url)
      feed_itens = []
      open(feed_url) do |http|
        response = http.read
        result = RSS::Parser.parse(response, false)
        output += "Feed Title: #{result.channel.title}<br />"
        result.items.each_with_index do |item, i|
          feed_itens << {
            :title => item.title,
            :link => item.link,
            :description => item.description,
            :linked_at => item.pubDate
          }
        end
      end
      feed_itens
    end
  end

  # lib/rss_parser.rb
  class WithReXML
    require 'rexml/document'

    def self.run(url, use_ssl = false)

      parsed_url = URI.parse(url)
      request = Net::HTTP::Get.new(parsed_url.path,{"Content-Type"=>"text/xml"})
      http = Net::HTTP.new(parsed_url.host, parsed_url.port)
      http.use_ssl = use_ssl

      xml = REXML::Document.new http.start {|http| http.request(request) }
      return
      data = {
        :title    => xml.root.elements['channel/title'].text,
        :home_url => xml.root.elements['channel/link'].text,
        :rss_url  => url,
        :items    => []
      }
      xml.elements.each '//item' do |item|
        new_items = {} and item.elements.each do |e|
          new_items[e.name.gsub(/^dc:(\w)/,"\1").to_sym] = e.text
        end
        data[:items] << new_items
      end
      data
    end
  end
  
end