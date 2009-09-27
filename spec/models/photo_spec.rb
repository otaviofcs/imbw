require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @valid_attributes = {
      :relevance => 50
    }
    @photo = Photo.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    # FIXME fazer teste decente
    # @photo.save.should be_true
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:gallery, :touch => true) }
  end

  describe "named_scopes" do
    it { should have_scope(:ordered).order("relevance DESC, id ASC") }
  end

  describe "validations" do
    it { should validate_presence_of(:relevance) }
    it { should validate_numericality_of(:relevance, :greater_than_or_equal_to => 0) }
  end

end
