require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BeerVote do
  before(:each) do
    @valid_attributes = {
      :title => 'Batemans'
    }
    @beer_vote = BeerVote.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @beer_vote.save.should be_true
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
  end
end
