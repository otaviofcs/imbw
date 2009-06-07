require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  #Delete this example and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end

  describe "GET show/1" do
    before(:each) do
      @user = mock_model(User)
      User.stub!(:find).and_return(@user)
    end
    def call_action(params={})
      default_params = { :id => "1" }
      params = default_params.merge!(params)
      get :show, params
    end
    it_should_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve user" do
      User.should_receive(:find).with("1").and_return(@user)
      call_action
    end
  end
end
