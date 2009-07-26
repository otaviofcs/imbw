module RpLinks

  class Base < ActiveResource::Base
    self.site = "https://links.riopro.com.br/rss.php/otavio"
  end

  class Bookmark < Base
    def find_all
      RpLinks::Bookmark.find(:all)
    end
  end

end