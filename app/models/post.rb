class Post < ActiveRecord::Base

  named_scope :available, :conditions => ["posts.active = ? and (not posts.published_at is null)", true]

  #
  # Validations
  #

  validates_presence_of :edited_at
  

end
