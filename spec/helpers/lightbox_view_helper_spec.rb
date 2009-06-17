require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LightboxViewHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(LightboxViewHelper)
  end

  describe ".lightbox_setup()" do
    it "should return nil if there are no flashes to show" do
      helper.lightbox_setup.should == "<script type=\"text/javascript\">\nLightboxOptions.fileLoadingImage = '/images/lightbox/loading.gif?1245204872';\nLightboxOptions.fileBottomNavCloseImage = '/images/lightbox/closelabel.gif?1245204872';\nLightboxOptions.labelImage = 'Imagem';\nLightboxOptions.labelOf = 'de';\n</script>\n"
    end
  end


end
