require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LightboxViewHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(LightboxViewHelper)
  end

  describe ".lightbox_init(nil)" do
    it "should return a script enabling a lightbox with all links with rel like lightbox" do
      helper.lightbox_init.should == "<script type=\"text/javascript\">\n//<![CDATA[\n$(document).ready(function(){\n$('a[rel*=lightbox]').lightbox();\n});\n//]]>\n</script>"
    end
  end

  describe ".lightbox_init(MY_GALLERY)" do
    it "should return a script enabling a lightbox with all links with rel = lightboxGALLERY_NAME" do
      helper.lightbox_init("GALLERY_NAME").should == "<script type=\"text/javascript\">\n//<![CDATA[\n$(document).ready(function(){\n$('a[rel=lightboxGALLERY_NAME]').lightbox();\n});\n//]]>\n</script>"
    end
  end


end
