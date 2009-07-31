require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  fixtures :users

  before(:each) do
    @valid_attributes = {
      :title => 'my first post',
      :body => ', it should be long enough to be considered correct'
    }
    @post = users(:the_blogger).posts.new(@valid_attributes)
    @post.edited_at = Time.current
  end

  it "should create a new instance given valid attributes" do
    @post.save.should be_true
  end

  describe "named_scopes" do
    it { should have_scope(:available).conditions(["posts.active = ? and (not posts.published_at is null)", true]) }
    it { should have_scope(:by_id).order("id desc") }
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:edited_at) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    # FIXME não está funcionando o teste de validação
    # it { should validate_length_of(:body, :minimum => 20) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end
end
