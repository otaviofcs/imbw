require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecentActivity do
  fixtures :notes

  before(:each) do
    @valid_attributes = {
      :recentable => notes(:twit_one)
    }
  end

  it "should create a new instance given valid attributes" do
    RecentActivity.create!(@valid_attributes)
  end
end
