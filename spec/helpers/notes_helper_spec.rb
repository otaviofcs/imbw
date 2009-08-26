require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotesHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(NotesHelper)
  end

  describe ".twitter_hashtags(twit)" do
    it "should render hashtags correctly" do
      helper.twitter_hashtags("oi, eu sou o #otavio e sou #bacana.").should == "oi, eu sou o <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=otavio\">#otavio</a> e sou <a href=\"/notes?search%5Btagged_with_on_tags%5D%5B%5D=bacana\">#bacana</a>."
    end
  end

end
