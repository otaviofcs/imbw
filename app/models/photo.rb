class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery

  has_attachment :content_type => :image,
    :storage => :file_system,
    :path_prefix => 'public/files',
    :size => 0.megabyte..3.megabytes,
    :thumbnails => {
      :small => '150x150>',
      :medium => '450x450>'
    }

  named_scope :recent, :order => 'id DESC'

  validates_as_attachment
  
end
