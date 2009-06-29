require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BeerVotesController do

  #Delete this example and add some real ones
  it "should use BeerVotesController" do
    controller.should be_an_instance_of(BeerVotesController)
  end

  describe "GET /index" do
    def call_action(params={})
      get :index, params
    end
    it_should_be_accessible_if_not_logged_in
    it_should_assign_a_page_title
    it "should assign a search variable" do
      BeerVote.should_receive(:search).and_return(BeerVote)
      call_action
      assigns[:search].should_not be_blank
    end
  end

end
