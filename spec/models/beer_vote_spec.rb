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

  it "should create a new instance given valid attributes" do
    @beer_vote.save.should be_true
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:twitter_profile) }
    it { should validate_presence_of(:commented_at) }
  end

  describe "object methods" do
    describe "parse_vote(vote_description)" do
      it "should parse a vote correctly" do
        BeerVote.parse_vote("#beer #bv 3.5 #bt Beck's #bd teste agora").should == {"bt"=>" Beck's ", "bv"=>" 3.5 ", "bd" => " teste agora"}
        BeerVote.parse_vote("#beer #bv 3.5 #bt Beck's #description teste agora").should == {"bt"=>" Beck's ", "bv"=>" 3.5 ", "description" => " teste agora"}
        BeerVote.parse_vote("#beer #bv 3.5 #bt Beck's #bc Alemanha #description teste agora").should == {"bc" => " Alemanha ", "bt"=>" Beck's ", "bv"=>" 3.5 ", "description" => " teste agora"}
      end
    end
  end

end
