require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @valid_attributes = {
      :title => 'my first post',
      :edited_at => Time.current
    }
    @post = Post.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @post.save.should be_true
  end

  describe "named_scopes" do
    it { should have_scope(:available).conditions(["posts.active = ? and (not posts.published_at is null)", true]) }
  end

  describe "validations" do
    it { should validate_presence_of(:edited_at) }
  end
end
