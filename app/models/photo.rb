class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery

  has_attachment :content_type => :image,
    :storage => :file_system,
    :size => 0.megabyte..3.megabytes,
    :resize_to => '450x450>',
    :thumbnails => { :thumb => '150x150>' }

  named_scope :recent, :order => 'id DESC'
  
end
