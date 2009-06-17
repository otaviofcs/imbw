class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery

  has_attachment :content_type => :image,
    :processor => :rmagick,
    :storage => :s3,
    :s3_access => :private,
    :size => 0.megabyte..3.megabytes,
    :thumbnails => {
      :small => "x120", # seta só a altura e a largura muda proporcionalmente
      :medium => "x450"
    }

  named_scope :recent, :order => 'id DESC'

  validates_as_attachment
  
end
