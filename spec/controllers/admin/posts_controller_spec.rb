require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PostsController do
  fixtures :users, :posts

  before(:each) do
    @user = users(:the_blogger)
    login_as @user
    @post = mock_model(Post, { :destroy => true, :save => true, :update_attributes => true })
  end

  #Delete this example and add some real ones
  it "should use Admin::PostsController" do
    controller.should be_an_instance_of(Admin::PostsController)
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
      Post.should_receive(:by_id).and_return(posts = [@post])
      call_action
    end
  end


  describe "GET /admin/posts/new" do
    before(:each) do
      Post.stub!(:new).and_return(@post)
    end
    def call_action(params={})
      default_params = {}
      params = default_params.merge!(params)
      get :new, params
    end
    it_should_not_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should retrieve posts" do
      Post.should_receive(:new).and_return(@post)
      call_action
    end
  end

  describe "GET /admin/posts/1/edit" do
    before(:each) do
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

  describe "DELETE /destroy/10" do
    before(:each) do
      Post.stub!(:find).and_return(@post)
    end
    def call_action(params={})
      default_params = {:id => 10}
      params = default_params.merge!(params)
      delete :destroy, params
    end
    it "should redirect to index" do
      call_action
      response.should redirect_to(admin_posts_path)
    end
    it "should receive a posts new" do
      Post.stub!(:find).and_return(@post)
      call_action
      assigns[:post].should == @post
    end
    it "should receive a posts find with 10" do
      Post.should_receive(:find).with("10").and_return(@post)
      call_action
    end
    it "should try to destroy post" do
      @post.should_receive(:destroy).and_return(true)
      call_action
    end
    it_should_set_a_flash_message(:success)
  end

  describe "POST /create" do
    before(:each) do
      Post.stub!(:new).and_return(@post)
    end
    def call_action(params={})
      default_params = {:post => {}}
      params = default_params.merge!(params)
      post :create, params
    end
    describe "on success" do
      it "should redirect to index" do
        call_action
        response.should redirect_to(admin_posts_path)
      end
      it "should receive a posts new" do
        Post.stub!(:new).and_return(@post)
        call_action
        assigns[:post].should == @post
      end
      it "should receive a posts find with 10" do
        Post.should_receive(:new).with({}).and_return(@post)
        call_action
      end
      it "should try to destroy post" do
        @post.should_receive(:save).and_return(true)
        call_action
      end
      it_should_set_a_flash_message(:success)
    end
    describe "on failure" do
      before(:each) do
        @post.stub!(:save).and_return(false)
      end
      it "should assing not a flash success on error" do
        @post.should_receive(:save).and_return(false)
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
      Post.stub!(:find).and_return(@post)
    end
    def call_action(params={})
      default_params = { :id => 10, :post => {}}
      params = default_params.merge!(params)
      post :update, params
    end
    describe "on success" do
      it "should redirect to index" do
        call_action
        response.should redirect_to(admin_posts_path)
      end
      it "should receive a posts new" do
        Post.stub!(:find).and_return(@post)
        call_action
        assigns[:post].should == @post
      end
      it "should receive a posts find with 10" do
        Post.should_receive(:find).with("10").and_return(@post)
        call_action :id => 10
      end
      it "should try to update post attributes" do
        @post.should_receive(:update_attributes).and_return(true)
        call_action
      end
      it_should_set_a_flash_message(:success)
    end
    describe "on failure" do
      before(:each) do
        @post.stub!(:update_attributes).and_return(false)
      end
      it "should assing not a flash success on error" do
        @post.should_receive(:update_attributes).and_return(false)
        call_action
        flash[:success].should be_blank
      end
      it "should render edit template" do
        call_action
        response.should render_template(:edit)
      end
      it_should_not_be_accessible_if_not_logged_in
      it_should_assign_a_page_title
    end
  end

end
