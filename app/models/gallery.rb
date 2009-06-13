class Gallery < ActiveRecord::Base

  belongs_to :user
  has_many :photos, :dependent => :destroy

  named_scope :recent, :order => 'id DESC'


  #
  # Options
  #

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :title, :description

  validates_presence_of :title

end
