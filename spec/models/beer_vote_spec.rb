require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BeerVote do
  before(:each) do
    @valid_attributes = {
      :title => 'Batemans',
      :twitter_profile => 'otaviofcs',
      :commented_at => Time.current,
    }
    @beer_vote = BeerVote.new(@valid_attributes)
  end

  it"should create a new instance given valid attributes"do
    @beer_vote.save.should be_true
  end

  
  describe "named_scopes" do
    it { should have_scope(:by_id).order("id desc") }
    it { should have_scope(:last_commented_at).order("commented_at desc") }
  end

  describe"validations"do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:twitter_profile) }
    it { should validate_presence_of(:commented_at) }
  end

  describe"object methods"do
    describe "self.last_update" do
      fixtures :beer_votes
      it "should retrive last commented at datetime" do
        @beer_vote = beer_votes(:first)
        BeerVote.last_update.should == @beer_vote.commented_at
      end
      it "should return nil if there is no vote" do
        BeerVote.destroy_all
        BeerVote.last_update.should be_nil
      end
    end
    describe"self.parse_vote(vote_description)"do
      it"should parse a vote correctly"do
        BeerVote.parse_vote("#beer #bv 3.5 #bt Beck's #bd teste agora").should == {"bt"=>"Beck's","bv"=>"3.5","bd"=>"teste agora"}
        BeerVote.parse_vote("#beer #bv 3.5 #bt Beck's #description teste agora").should == {"bt"=>"Beck's","bv"=>"3.5","description"=>"teste agora"}
        BeerVote.parse_vote("#beer #bv 3.5 #bt Beck's #bc Alemanha #description teste agora").should == {"bc"=>"Alemanha","bt"=>"Beck's","bv"=>"3.5","description"=>"teste agora"}
      end
    end
    describe"self.create_one_vote(twitter_update)"do
      it"should create a BeerVote correctly"do
        @twitter_update = mock_model(Mash, {
          :created_at => "Sat, 20 Jun 2009 17:02:15 +0000",
          :from_user => "otaviofcs",
          :from_user_id => 19454543,
          :id => 2254625870,
          :iso_language_code => "pt",
          :profile_image_url => "http://s3.amazonaws.com/twitter_production/profile_images/255710892/avatar_mini_normal.jpg",
          :source => "&lt;a href=&quot;http://twitterhelp.blogspot.com/2008/05/twitter-via-mobile-web-mtwittercom.html&quot;&gt;mobile web&lt;/a&gt;",
          :text => "#beer #bt Beck's #bv 3.5 #bd comparando a Heineken e a Beck's, a última tem muito mais corpo e presença. Mas ambas tem aquele amargo no fim do gole.",
          :to_user_id => nil
        })
        BeerVote.destroy_all
        BeerVote.create_one_vote(@twitter_update).should be_true
        BeerVote.first.title.should == "Beck's"
        BeerVote.first.vote.should == 3.5
      end
    end
  end

end
