require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do
  fixtures :users

  before(:each) do
    @user = users(:the_blogger)
    login_as @user
  end

  #Delete this example and add some real ones
  it "should use Admin::UsersController" do
    controller.should be_an_instance_of(Admin::UsersController)
  end

  describe "GET /admin/users" do
    before(:each) do
      @user = mock_model(User)
      User.stub!(:all).and_return([@user])
    end
    def call_action(params={})
      default_params = {}
      params = default_params.merge!(params)
      get :index, params
    end
    it_should_not_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve users" do
      User.should_receive(:all).and_return([@user])
      call_action
    end
  end


  describe "GET /admin/users/new" do
    before(:each) do
      @user = mock_model(User)
      User.stub!(:new).and_return(@user)
    end
    def call_action(params={})
      default_params = {}
      params = default_params.merge!(params)
      get :new, params
    end
    it_should_not_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve users" do
      User.should_receive(:new).and_return(@user)
      call_action
    end
  end

  describe "GET /admin/users/1/edit" do
    before(:each) do
      @user = mock_model(User)
      User.stub!(:find).and_return(@user)
    end
    def call_action(params={})
      default_params = { :id => "1" }
      params = default_params.merge!(params)
      get :edit, params
    end
    it_should_not_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve users" do
      User.should_receive(:find).with("1").and_return(@user)
      call_action
    end
  end

end
