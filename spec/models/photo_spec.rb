require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @valid_attributes = {
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
    it { should have_scope(:by_id).order("id ASC") }
  end

end
