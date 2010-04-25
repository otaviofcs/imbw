require 'spec_helper'

describe Video do
  before(:each) do
    @valid_attributes = {
      :title => 'um título'
    }
  end

  it "should create a new instance given valid attributes" do
    Video.create!(@valid_attributes)
  end


  describe "associations" do
    it { should have_many(:comments, :as => :commentable, :dependent => :destroy) }
  end

end
