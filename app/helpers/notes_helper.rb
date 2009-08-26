module NotesHelper

  URL_REGEXP = /[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&\?\/.=]+/
  TWITTER_USERNAMES_REGEXP = /[@]+[A-Za-z0-9-_]+/
  TWITTER_HASHTAGS = /[#]+[A-Za-z0-9-_]+/

  # baseado na versão para javascript existente em:
  # http://www.simonwhatley.co.uk/examples/twitter/prototype/
  def formatting_twits(twit)
    new_twit = twit

  end

  def twitter_urls(twit)
    twit
  end

  def twitter_usernames(twit)
    twit
  end

  def twitter_hashtags(twit)
    twit
  end
end
