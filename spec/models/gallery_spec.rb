require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Gallery do
  before(:each) do
    @valid_attributes = {
      :title => 'my title'
    }
    @gallery = Gallery.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @gallery.save.should be_true
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:photos, :dependent => :destroy) }
    it { should have_many(:comments, :as => :commentable, :dependent => :destroy) }
  end
  
  describe "named_scopes" do
    it { should have_scope(:recent).order("id DESC") }
  end

  describe "creating or updating" do
    it { should validate_presence_of(:title) }
  end

end
