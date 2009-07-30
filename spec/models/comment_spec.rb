require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  fixtures :galleries

  before(:each) do
    @valid_attributes = {
      :name => 'astolfo',
      :comment => 'meu commentário é, ...'
    }
    @comment = galleries(:one).comments.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @comment.save.should be_true
  end


  describe 'associations' do
    it { should belong_to(:gallery) }
  end

  #
  # Validations
  #

  describe 'validations' do
    it { should validate_presence_of(:gallery_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:comment) }
  end

end
