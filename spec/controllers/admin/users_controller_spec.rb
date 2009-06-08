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

  describe "DELETE /destroy/10" do
    before(:each) do
      User.stub!(:find).and_return(@user)
    end
    def call_action(params={})
      default_params = {:id => 10}
      params = default_params.merge!(params)
      delete :destroy, params
    end
    it "should redirect to index" do
      call_action
      response.should redirect_to(admin_users_path)
    end
    it "should receive a users new" do
      User.stub!(:find).and_return(@user)
      call_action
      assigns[:user].should == @user
    end
    it "should receive a users find with 10" do
      User.should_receive(:find).with("10").and_return(@user)
      call_action
    end
    it "should try to destroy user" do
      @user.should_receive(:destroy).and_return(true)
      call_action
    end
    it_should_set_a_flash_message(:success)
  end

  describe "POST /create" do
    before(:each) do
      @user.stub!(:save).and_return(true)
      User.stub!(:new).and_return(@user)
    end
    def call_action(params={})
      default_params = {:user => {}}
      params = default_params.merge!(params)
      post :create, params
    end
    describe "on success" do
      it "should redirect to index" do
        call_action
        response.should redirect_to(admin_users_path)
      end
      it "should receive a users new" do
        User.stub!(:new).and_return(@user)
        call_action
        assigns[:user].should == @user
      end
      it "should receive a users find with 10" do
        User.should_receive(:new).with({}).and_return(@user)
        call_action
      end
      it "should try to destroy user" do
        @user.should_receive(:save).and_return(true)
        call_action
      end
      it_should_set_a_flash_message(:success)
    end
    describe "on failure" do
      before(:each) do
        @user.stub!(:save).and_return(false)
      end
      it "should assing not a flash success on error" do
        @user.should_receive(:save).and_return(false)
        call_action
        flash[:success].should be_blank
      end
      it "should render new template" do
        call_action
        response.should render_template(:new)
      end
      it_should_not_be_accessible_if_not_logged_in
      it_should_assign_a_page_title
    end
  end

  describe "PUT /update" do
    before(:each) do
      @user.stub!(:save).and_return(true)
      User.stub!(:find).and_return(@user)
    end
    def call_action(params={})
      default_params = {:user => {}}
      params = default_params.merge!(params)
      post :update, params
    end
    describe "on success" do
      it "should redirect to index" do
        call_action
        response.should redirect_to(admin_users_path)
      end
      it "should receive a users new" do
        User.stub!(:find).and_return(@user)
        call_action
        assigns[:user].should == @user
      end
      it "should receive a users find with 10" do
        User.should_receive(:find).with("10").and_return(@user)
        call_action :id => 10
      end
      it "should try to destroy user" do
        @user.should_receive(:save).and_return(true)
        call_action
      end
      it_should_set_a_flash_message(:success)
    end
    describe "on failure" do
      before(:each) do
        @user.stub!(:save).and_return(false)
      end
      it "should assing not a flash success on error" do
        @user.should_receive(:save).and_return(false)
        call_action
        flash[:success].should be_blank
      end
      it "should render new template" do
        call_action
        response.should render_template(:edit)
      end
      it_should_not_be_accessible_if_not_logged_in
      it_should_assign_a_page_title
    end
  end

end
