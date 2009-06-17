class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery

  has_attachment :content_type => :image,
    :processor => :rmagick,
    :storage => :file_system,
    :path_prefix => 'public/photos',
    :size => 0.megabyte..3.megabytes,
    :thumbnails => {
      :small => [100,100],
      :medium => [450,450]
    }

  named_scope :recent, :order => 'id DESC'

  validates_as_attachment
  
end
