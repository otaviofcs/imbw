require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GalleriesController do

  #Delete this example and add some real ones
  it "should use Open::GalleriesController" do
    controller.should be_an_instance_of(GalleriesController)
  end
  describe "GET /index" do
    def call_action params={}
      get :index, params
    end
    it_should_assign_a_page_title
  end

  describe "GET /index" do
    def call_action params={}
      get :index, params
    end
    it_should_assign_a_page_title
  end

  describe "GET /search" do
    fixtures :galleries
    def call_action params={}
      get :search, params
    end
    describe "no access" do
      it "should redirect to index page" do
        call_action
        response.should redirect_to(galleries_path)
      end
    end
    describe "success" do
      it "should redirect to gallery path" do
        @gallery = galleries(:one)
        call_action :id => "#{@gallery.id}-#{@gallery.public_code}"
        response.should redirect_to(gallery_path(:id => "#{@gallery.id}-#{@gallery.public_code}"))
      end
    end
  end


end
