require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Controller de teste para criação/recuperação do filtro
# da sessão.
class ApplicationTestController < ApplicationController

  before_filter :user_required
  
  skip_before_filter :user_required, :only => [ :test_without_user ]

  def test_without_user
    render 'user_sessions/new'
  end

  def test_with_user
    render 'user_sessions/new'
  end

end

describe ApplicationTestController do
  fixtures :users

  before(:each) do
    @user = users(:the_blogger)
    login_as @user
  end

#  #Delete this example and add some real ones
  it "should use ApplicationTestController" do
    controller.should be_an_instance_of(ApplicationTestController)
  end

  describe "GET /test_no_user" do
    def do_get
      get :test_without_user
    end
    describe "on success" do
      it "should succeed" do
        do_get
        response.should be_success
      end
      it "should render correct test page" do
        do_get
        response.should render_template('user_sessions/new')
      end
    end
  end

  describe "GET /test_with_user" do
    def do_get
      get :test_with_user
    end
    describe "on success" do
      it "should succeed" do
        do_get
        response.should be_success
      end
      it "should render correct test page" do
        do_get
        response.should render_template('user_sessions/new')
      end
    end
    describe "on failure" do
      before(:each) do
        login_as nil
      end
      it "should fail" do
        do_get
        response.should_not be_success
      end
      it "should be redirected" do
        do_get
        response.should redirect_to(login_path)
      end
    end
  end

end
