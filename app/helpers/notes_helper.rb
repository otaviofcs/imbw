module NotesHelper

  # baseado na versão para javascript existente em:
  # http://www.simonwhatley.co.uk/examples/twitter/prototype/
  def parse_twit(twit)
    new_twit = twit
    new_twit = self.twitter_urls(new_twit)
    new_twit = self.twitter_usernames(new_twit)
    new_twit = self.twitter_hashtags(new_twit)
    new_twit
  end

  def twitter_urls(twit)
    twit_urls = twit.scan(/[A-Za-z]+:\/\/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_:%&\?\/.=]+/)
    twit_urls.each do |twit_url|
      twit = twit.gsub(/#{twit_url}/, link_to( twit_url, twit_url ) )
    end
    twit
  end

  def twitter_usernames(twit)
    twit.gsub(/@([\w\-_]+)/) do
      link_to("@#{$1}", "http://twitter.com/#{$1}" )
    end
  end

  def twitter_hashtags(twit)
    twit.gsub(/#([\w\-_]+)/i) do
      link_to("##{$1}", notes_path(:search => { :tagged_with_on_tags => $1 }) )
    end
  end
end
