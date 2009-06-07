module CommonSpecHelperMethods
  
  alias :doing :lambda
  
  # 
  # Model Mocks
  # 

  # logs in the supplied user
  def login_as(user=nil)
    activate_authlogic
    if user # login
      UserSession.create(user)
    else # logout
      UserSession.find.destroy
    end
  end
  
  def mock_user_session
    mock_model UserSession, { :destroy => true, :save => true }
  end


  # rspec example used all over the admin controllers. assumes there's a
  # 'call_action(params={})' method that calls the controller action.
  #
  # tests if the action cannot be accessed anonimously.
  def it_should_not_be_accessible_if_not_logged_in(params={})
    it "should not be accessible if not logged in" do
      login_as(nil)
      call_action(params)
      response.should_not be_success
      response.should be_redirect
      response.should redirect_to login_path
    end
  end

  # rspec example used all over the non admin controllers. assumes there's a
  # 'call_action(params={})' method that calls the controller action.
  #
  # tests if the action cannot be accessed anonimously.
  def it_should_be_accessible_if_not_logged_in(params={})
    it "should be accessible if not logged in" do
      call_action(params)
      response.should be_success
      response.should_not be_redirect
    end
  end

  # rspec example used all over the super_admin controllers. assumes there's a
  # 'call_action(params={})' method that calls the controller action.
  #
  # tests if an instance variable called @page_title is avaiable for the view
  # and if it's not blank.
  #
  # if you pass a text, also tests if the variable text matches the one you
  # supplied.
  def it_should_assign_a_page_title(params={}, text=nil)
    it "should assign a page title" do
      call_action(params)
      assigns[:page_title].should_not be_blank
    end
    if text
      it "should assign a page title with the text '#{text}'" do
        call_action(params)
        assigns[:page_title].should == text
      end
    end
  end

  # rspec example used all over the super_admin controllers. assumes there's a
  # 'call_action(params={})' method that calls the controller action.
  #
  # tests if a flash message of the supplied type exists (ie, isn't blank).
  # type should be a symbol or string, ie :notice ou :error
  #
  # if you supply a text, also tests if the flash message matches the supplied
  # text.
  def it_should_set_a_flash_message(type, params={}, text=nil)
    it "should set a flash #{type.to_s} message" do
      call_action(params)
      flash[type.to_sym].should_not be_blank
    end
    if text
      it "should set a flash #{type.to_s} message with the text '#{text}'" do
        call_action(params)
        flash[type.to_sym].should == text
      end
    end
  end

  #
  # Ruby Improvements
  #
  
  # rSpec Hash additions.
  # From http://wincent.com/knowledge-base/Fixtures_considered_harmful%3F
  module HashAdditions
    # Filter keys out of a Hash.
    #
    #   { :a => 1, :b => 2, :c => 3 }.except(:a)
    #   => { :b => 2, :c => 3 }
    def except(*keys)
      self.reject { |k,v| keys.include?(k || k.to_sym) }
    end

    # Override some keys.
    #
    #   { :a => 1, :b => 2, :c => 3 }.with(:a => 4)
    #   => { :a => 4, :b => 2, :c => 3 }
    def with(overrides={})
      self.merge overrides
    end

    # Returns a Hash with only the pairs identified by +keys+.
    #
    #   { :a => 1, :b => 2, :c => 3 }.only(:a)
    #   => { :a => 1 }
    def only(*keys)
      self.reject { |k,v| !keys.include?(k || k.to_sym) }
    end
  end

end

class Hash
  include CommonSpecHelperMethods::HashAdditions
end
