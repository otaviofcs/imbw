# lib/rss_parser.rb
module RssParser

  # Parser Rss
  #
  # RssParser::WithReXML.run 'links.riopro.com.br',443,'https://links.riopro.com.br/rss.php/otavio', true
  class WithReXML
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
        data[:items] << new_items
      end
      data
    end
  end
  
end