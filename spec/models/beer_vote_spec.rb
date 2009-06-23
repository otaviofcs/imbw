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
      before(:each) do
        @vote_description = "#beer #bv 3.5 #bt Beck's #bd teste agora"
      end
      it "should parse a vote correctly" do
        BeerVote.parse_vote(@vote_description).should == {"beer"=>" ", "bt"=>" Beck's ", "bv"=>" 3.5 "}
      end
    end
  end

end
