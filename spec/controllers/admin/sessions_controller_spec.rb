require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::SessionsController do
  fixtures :users

  it "should use Admin::SessionsController" do
    controller.should be_an_instance_of(Admin::SessionsController)
  end

  it "should inherit from AdminController" do
    controller.is_a?(AdminController).should be_true
  end

  describe "new" do
    def call_action(params={})
      get :new, params
    end
    it "should get new" do
      call_action
      response.should be_success
    end
    it_should_assign_a_page_title
    it_should_be_accessible_if_not_logged_in
  end

  describe "create" do
    before(:each) do
      activate_authlogic
    end
    def call_action(params={})
      post :create, params
    end
    it "should create a -user session with valid login" do
      call_action :user_session => { :login => "the_blogger", :password => "123456" }
      UserSession.find.should_not be_nil
      UserSession.find.record.should == users(:the_blogger)
      flash[:success].should_not be_nil
      response.should redirect_to(root_path)
    end
    [
      {:login => "the_blogger",        :password => "senha_errada"},
      {:login => "pessoa_inexistente", :password => "123456"}
    ].each do |params_hash|
      it "should not create a -user session with invalid params" do
        call_action :user_session => params_hash
        UserSession.find.should be_nil
        flash[:error].should_not be_nil
        response.should_not redirect_to(root_path)
        response.should render_template(:new)
      end
    end
  end

  describe "destroy" do
    before(:each) do
      activate_authlogic
      @user = users(:the_blogger)
      login_as @user
    end
    def call_action(params={})
      delete :destroy, params
    end
    it "should destroy a -user session" do
      call_action
      UserSession.find.should be_nil
      response.should redirect_to(login_path)
    end
    it_should_set_a_flash_message(:notice)
  end

end
