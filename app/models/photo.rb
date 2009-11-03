require 'digest/sha1'

class Photo < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery, :touch => true

  has_attachment :content_type => :image,
    :processor => 'MiniMagick',
    :storage => :s3,
    :s3_access => :private,
    :size => 0.megabyte..3.megabytes,
    :thumbnails => {
      :small => "x100", # seta só a altura e a largura muda proporcionalmente
      :mobile => "x300",
      :medium => "x500"
    }

  # relevance tem um valor atribuído por default, mas pode ser alterado para
  # ajudar a ordenar as fotos
  named_scope :ordered, :order => 'relevance DESC, id ASC'

  # seleciona apenas as fotos que não foram inabilitadas
  named_scope :enable, :conditions => [:disable, 0]

  #
  # Initialization
  #

  def after_initialize
    self.relevance = 50 unless self.relevance
    self.disable = 0 if self.disable.blank?
  end

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
  validates_presence_of :relevance
  validates_numericality_of :relevance, :greater_than_or_equal_to => 0

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
