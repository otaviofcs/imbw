class Comment < ActiveRecord::Base

  #
  # Constants
  #

  include RioproConstants
  
  cattr_reader :per_page
  @@per_page = 10


  belongs_to :gallery

  attr_accessible :name, :comment, :website, :email


  #
  # Named Scopes
  #
  named_scope :by_id, :order => "id desc"
  

  validates_presence_of :gallery_id
  validates_presence_of :name
  validates_presence_of :comment

  validates_format_of :email,
    :with => EMAIL_REGEX,
    :allow_blank => true
  validates_format_of :website,
    :with => WEB_SITE_REGEX,
    :allow_blank => true

end
