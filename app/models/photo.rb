require 'digest/sha1'

class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery

  has_attachment :content_type => :image,
    :processor => :rmagick,
    :storage => :s3,
    :s3_access => :private,
    :size => 0.megabyte..3.megabytes,
    :thumbnails => {
      :small => "x100", # seta só a altura e a largura muda proporcionalmente
      :medium => "x500"
    }

  named_scope :by_id, :order => 'id ASC'

  #
  # Callbacks
  #

  def before_validation
    self.photo_hash = self.make_token unless self.photo_hash
  end

  #
  # Validations
  #

  validates_as_attachment

  validates_presence_of :photo_hash

  #
  # Instance Methods
  #

  def public_filename(thumbnail = nil, expires_in=1.hour)
    thumb = thumbnail.to_s if thumbnail
    self.authenticated_s3_url(thumb, :expires_in => expires_in)
  end

  protected

    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    def make_token
      secure_digest(Time.now, (2..11).map{ rand.to_s })
    end
end
