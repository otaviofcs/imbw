class Comment < ActiveRecord::Base

  belongs_to :gallery

  attr_accessible :name, :comment, :website, :email

  validates_presence_of :gallery_id
  validates_presence_of :name
  validates_presence_of :comment

end
