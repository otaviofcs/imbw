class Post < ActiveRecord::Base

  #
  # Association
  #

  belongs_to :user

  named_scope :available, :conditions => ["posts.active = ? and (not posts.published_at is null)", true]
  named_scope :by_id, :order => "id desc"

  #
  # Validations
  #

  validates_presence_of :user_id

  validates_presence_of :title

  validates_presence_of :body
  validates_length_of :body, :minimum => 20

  validates_presence_of :edited_at
  

end
