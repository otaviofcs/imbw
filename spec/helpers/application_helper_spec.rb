require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ApplicationHelper)
  end
  
  describe ".display_flashes()" do
    it "should return nil if there are no flashes to show" do
      helper.display_flashes.should be_nil
    end
    it "should return a div with the flash message if message is a simple string" do
      flash[:notice] = "Notice message"
      helper.display_flashes.should have_tag("div[id='flash_notice'][class='flash']") do
        with_tag "p", "Notice message"
        with_tag "span[class='close']" do
          with_tag "a[onclick='$(this).up(\'#flash_notice\').remove(); return false;']", "fechar"
        end
      end
    end
  end

end