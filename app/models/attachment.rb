class Attachment < ActiveRecord::Base

   belongs_to :user

   has_attachment :content_type => :image,
    :processor => :rmagick,
    :storage => :s3,
    :s3_access => :public,
    :size => 0.megabyte..2.megabytes,
    :thumbnails => {
      :thumb => "x50",
      :small => "x200",
      :medium => "x400"
    }

end
