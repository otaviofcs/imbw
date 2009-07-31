require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Link do
  fixtures :links
  
  before(:each) do
    @valid_attributes = {
      :link => 'http://a.com',
      :title => 'a link',
      :linked_at => Time.current
    }
    @link = Link.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @link.save.should be_true
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:linked_at) }
    it { should validate_presence_of(:link) }
    it { should validate_uniqueness_of(:link) }
  end
end
