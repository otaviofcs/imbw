require 'digest/sha1'

class Video < ActiveRecord::Base


  has_attachment :content_type => :video,
    :storage => :s3,
    :s3_access => :private

  #
  # Callbacks
  #

  def before_validation
    self.video_hash = self.make_token unless self.video_hash
  end

  #
  # Options
  #

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :title, :description


  protected

    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    def make_token
      secure_digest(Time.now, (2..11).map{ rand.to_s })
    end
end
