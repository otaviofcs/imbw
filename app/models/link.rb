class Link < ActiveRecord::Base

  acts_as_taggable_on :tags

  #
  # Options
  #
  cattr_reader :per_page
  @@per_page = 10

  # Validations
  #
  validates_presence_of :link
  validates_presence_of :title

end
