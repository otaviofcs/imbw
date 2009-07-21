class Link < ActiveRecord::Base

  acts_as_taggable_on :tags

  cattr_reader :per_page
  @@per_page = 10

end
