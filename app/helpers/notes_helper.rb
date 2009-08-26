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
    users = twit.scan(/@([A-Za-z0-9\-_]+)/)
    users.each do |user|
      twit = twit.gsub(/@#{user}/, link_to("@#{user}", "http://twitter.com/#{user}" ) )
    end
    twit
  end

  def twitter_hashtags(twit)
    hashtags = twit.scan(/#([A-Za-z0-9\-_]+)/i)
    hashtags.each do |tag|
      twit = twit.gsub(/##{tag}/, link_to("##{tag}", notes_path(:search => { :tagged_with_on_tags => tag }) ) )
    end
    twit
  end
end
