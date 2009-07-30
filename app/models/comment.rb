class Comment < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 10


  belongs_to :gallery

  attr_accessible :name, :comment, :website, :email

  validates_presence_of :gallery_id
  validates_presence_of :name
  validates_presence_of :comment

end
