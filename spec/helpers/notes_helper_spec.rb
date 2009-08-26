require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotesHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(NotesHelper)
  end

  describe ".formatting_twits(twit)" do
    it "should replace correctly" do
      helper.parse_twit("com um link http://riopro.com.br, de @otaviofcs.").should == "com um link <a href=\"http://riopro.com.br\">http://riopro.com.br</a>, de <a href=\"http://twitter.com/otaviofcs\">@otaviofcs</a>."
      helper.parse_twit("com um #link http://riopro.com.br, de @otaviofcs.").should == "com um <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=link\">#link</a> <a href=\"http://riopro.com.br\">http://riopro.com.br</a>, de <a href=\"http://twitter.com/otaviofcs\">@otaviofcs</a>."
      helper.parse_twit("com um link http://riopro.com.br, de @otaviofcs. #teste").should == "com um link <a href=\"http://riopro.com.br\">http://riopro.com.br</a>, de <a href=\"http://twitter.com/otaviofcs\">@otaviofcs</a>. <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=teste\">#teste</a>"
    end
  end

  describe ".twitter_urls(twit)" do
    it "should replace correctly" do
      helper.twitter_urls("link http://bit.ly/roeorer").should == "link <a href=\"http://bit.ly/roeorer\">http://bit.ly/roeorer</a>"
    end
  end

  describe ".twitter_usernames(twit)" do
    it "should render twitter user correctly" do
      helper.twitter_usernames("nada demais, aqui mesmo.").should == "nada demais, aqui mesmo."
      helper.twitter_usernames("aqui sim, temos o usuário @otaviofcs e o usuário @pmirandola.").should == "aqui sim, temos o usuário <a href=\"http://twitter.com/otaviofcs\">@otaviofcs</a> e o usuário <a href=\"http://twitter.com/pmirandola\">@pmirandola</a>."
      helper.twitter_usernames("aqui sim, temos @otaviofcs como usuário.").should == "aqui sim, temos <a href=\"http://twitter.com/otaviofcs\">@otaviofcs</a> como usuário."
    end
  end

  describe ".twitter_hashtags(twit)" do
    it "should render hashtags correctly" do
      helper.twitter_hashtags("oi, eu sou o #otavio e sou #bacana.").should == "oi, eu sou o <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=otavio\">#otavio</a> e sou <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=bacana\">#bacana</a>."
      helper.twitter_hashtags("oi, eu sou o otavio e sou bacana.").should == "oi, eu sou o otavio e sou bacana."
      helper.twitter_hashtags("com um link http://riopro.com.br, de @otaviofcs. #teste").should == "com um link http://riopro.com.br, de @otaviofcs. <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=teste\">#teste</a>"
    end
  end

end
