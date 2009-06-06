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
    it "should get new" do
      get :new
      response.should be_success
    end
  end

  describe "create" do
    before(:each) do
      activate_authlogic
    end
    it "should create a -user session with valid login" do
      post :create, :user_session => { :login => "the_blogger", :password => "123456" }
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
        post :create, :user_session => params_hash
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
    end
    it "should destroy a -user session" do
      delete :destroy
      UserSession.find.should be_nil
      response.should redirect_to(login_path)
    end
  end

end
