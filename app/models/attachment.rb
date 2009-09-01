class Attachment < ActiveRecord::Base

  #
  # Options
  #
  cattr_reader :per_page
  @@per_page = 10

  belongs_to :user

  has_attachment :content_type => :image,
    :processor => :rmagick,
    :storage => :s3,
    :s3_access => 'public-read',
    :size => 0.megabyte..2.megabytes,
    :thumbnails => {
      :thumb => "x50",
      :small => "x200",
      :mobile => "x300",
      :medium => "x400"
  }

end
