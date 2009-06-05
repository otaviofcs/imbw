require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :users

  before(:each) do
    @valid_attributes = {
      :login => 'super_sunda',
      :password => '654321',
      :password_confirmation => '654321'
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  describe "on creation" do
    it { should validate_presence_of(:login) }
    it { should validate_uniqueness_of(:login, :case_sensitive => false) }
    it { should validate_length_of(:login, :within => 3..40) }
    it { should allow_values_for(:login, 'lala', '3213', 'das.das-aDS_dsa', 'áçãoü32') }
    it { should_not allow_values_for(:login, nil, '', 'ds!dsa', 'dsa d sad', '#dasd', "ádsa\n") }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password, :within => 6..40) }

    it { should validate_presence_of(:password_confirmation) }

    it "should force all logins to be lowercase" do
      u = User.new(@valid_attributes.with(:login => 'MAIÚSculo'))
      u.should be_valid
      u.login.should == 'maiúsculo'
    end
  end

  describe "on update" do
    before(:each) do
      User.create!(@valid_attributes)
      @user = User.find_by_login(@valid_attributes[:login])
    end
    it { @user.should_not validate_presence_of(:password) }
    it { @user.should_not validate_presence_of(:password_confirmation) }
  end

  describe "on update, changing password" do
    before(:each) do
      User.create!(@valid_attributes)
      @user = User.find_by_login(@valid_attributes[:login])
      @user.password = 'new_passord'
    end
    it { @user.should validate_presence_of(:password_confirmation) }
  end

end
