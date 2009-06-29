require 'digest/sha1'

class Gallery < ActiveRecord::Base

  belongs_to :user
  has_many :photos, :dependent => :destroy

  named_scope :recent, :order => 'id DESC'
  
  #
  # Callbacks
  #

  def before_validation
    self.gallery_hash = self.make_token unless self.gallery_hash
  end

  #
  # Options
  #

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :title, :description, :public_code

  #
  # Validations
  #

  validates_presence_of :title
  
  validates_presence_of :gallery_hash

  protected

    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    def make_token
      secure_digest(Time.now, (2..11).map{ rand.to_s })
    end

end
