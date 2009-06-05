class Post < ActiveRecord::Base

  named_scope :available, :conditions => ["posts.active = ? and (not posts.published_at is null)", true]
end
