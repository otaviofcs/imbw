require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  fixtures :users

  before(:each) do
    @user = users(:the_blogger)
    login_as @user
  end

  #Delete this example and add some real ones
  it "should use PostsController" do
    controller.should be_an_instance_of(PostsController)
  end

  describe "GET index" do
    def call_action(params={})
      default_params = {}
      params = default_params.merge!(params)
      get :index, params
    end
    it_should_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve posts" do
      @post = mock_model(Post)
      Post.should_receive(:available).and_return(posts = [@post])
      posts.should_receive(:by_id).and_return(posts)
      call_action
    end
  end

  describe "GET show/1" do
    before(:each) do
      @post = mock_model(Post)
      Post.stub!(:find).and_return(@post)
    end
    def call_action(params={})
      default_params = { :id => "1" }
      params = default_params.merge!(params)
      get :show, params
    end
    it_should_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve posts" do
      Post.should_receive(:find).with("1").and_return(@post)
      call_action
    end
  end

end