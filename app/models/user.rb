class User < ActiveRecord::Base
  # authlogic
  acts_as_authentic

  #
  # Association
  #

  has_many :posts
  has_many :galleries


  #
  # Named Scopes
  #

  # retorna contratos mais recentemente criados
  named_scope :by_login, :order => "users.login"


  #
  # Constants
  #

  LOGIN_REGEX = /\A\w[\w\.\-_]+\z/ # only (ascii) letters, numbers and .-_
  EMAIL_NAME_REGEX = '[\w\.%\+\-]+'
  DOMAIN_HEAD_REGEX = '(?:[A-Z0-9\-]+\.)+'
  DOMAIN_TLD_REGEX = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  EMAIL_REGEX = /\A#{EMAIL_NAME_REGEX}@#{DOMAIN_HEAD_REGEX}#{DOMAIN_TLD_REGEX}\z/i

  #
  # Initialization
  #

  def after_initialize
    set_default_time_zone
  end

  #
  # Options
  #

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation

  validates_presence_of :login
  validates_uniqueness_of :login,
    :case_sensitive => false
  validates_length_of :login,
    :within => 3..40,
    :allow_blank => false
  validates_format_of :login,
    :with => LOGIN_REGEX,
    :allow_blank => false

  validates_presence_of :email
  validates_length_of :email,
    :within => 6..100,
    :allow_blank => true
  validates_uniqueness_of :email,
    :case_sensitive => false
  validates_format_of :email,
    :with => EMAIL_REGEX,
    :allow_blank => true

  validates_presence_of :password,
    :if => :password_required?
  validates_length_of :password,
    :within => 6..40,
    :allow_blank => true,
    :if => :password_required?
  validates_confirmation_of :password,
    :if => :password_required?

  validates_presence_of :password_confirmation,
    :if => :password_required?


  #
  # Public Instance Methods
  #

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected

    # after_initialize: seta o fuso horário padrão do sistema como fuso do usuário,
    # se o mesmo não tiver sido especificado.
    def set_default_time_zone
      self.time_zone = Time.zone.name if self.time_zone.blank?
    end

    def password_required?
      crypted_password.blank? || !password.blank?
    end

end
