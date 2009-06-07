require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PostsController do
  fixtures :users

  before(:each) do
    @user = users(:the_blogger)
    login_as @user
  end

  #Delete this example and add some real ones
  it "should use Admin::PostsController" do
    controller.should be_an_instance_of(Admin::PostsController)
  end

  describe "GET /admin/posts/1/edit" do
    before(:each) do
      @post = mock_model(Post)
      Post.stub!(:find).and_return(@post)
    end
    def call_action(params={})
      default_params = { :id => "1" }
      params = default_params.merge!(params)
      get :edit, params
    end
    it_should_not_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve posts" do
      Post.should_receive(:find).with("1").and_return(@post)
      call_action
    end
  end

end
