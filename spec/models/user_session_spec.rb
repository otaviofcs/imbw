require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSession do
  fixtures :users
  before(:each) do
    @valid_attributes = {
      :login => 'the_blogger',
      :password => '123456'
    }
  end

  it "should create a new instance given valid attributes" do
    @user_session = UserSession.new(@valid_attributes)
    @user_session.save.should be_true
  end

end
