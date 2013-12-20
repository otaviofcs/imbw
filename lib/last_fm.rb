# lib/last_fm.rb
module LastFm

  # Parser da API do LastFm
  #
  # Exemplos:
  # 9 Álbuns mais tocados
  # LastFm::Api.get 'user.gettopalbums', 'a19dfed5ce7bc8c06c7e4f1d195e4d2a', "user=otaviofcs&limit=9"
  # 10 músicas mais recentes
  # LastFm::Api.get 'user.getrecenttracks', 'a19dfed5ce7bc8c06c7e4f1d195e4d2a', "user=otaviofcs&limit=10"
  class Api

    def self.get(method, api_key, extraParams)
      host = "ws.audioscrobbler.com"
      url="/2.0/?format=json&method=mymethod&api_key=mykey"
      
      parsed_json = nil
      response = Net::HTTP.get_response(host,full_url)
      parsed_json = ActiveSupport::JSON.decode(response.body)
      parsed_json
    end
  end
end
