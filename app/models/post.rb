class Post < ActiveRecord::Base

  acts_as_textiled :body

  acts_as_taggable_on :tags

  #
  # Options
  #

  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :title, :body, :active, :tag_list

  cattr_reader :per_page
  @@per_page = 10


  #
  # Association
  #

  belongs_to :user

  #
  # Named Scopes
  #

  named_scope :available, :conditions => ["posts.active = ? and (not posts.published_at is null)", true]
  named_scope :by_id, :order => "id desc"


  named_scope :tagged_with_on_tags, lambda { |tag|
    # match_all é para que as condições sejam associativas.
    # ou seja, o objeto tem que ter todas as tags descritas
    options = { :on => :tags, :match_all => true }
    find_options_for_find_tagged_with(tag, options)
  }

  before_save :update_edited_at

  #
  # Validations
  #

  validates_presence_of :user_id

  validates_presence_of :title

  validates_presence_of :body
  validates_length_of   :body, :minimum => 20

  validates_presence_of :edited_at

  def body_truncated
    cut = self.body =~ /<em>more<\/em>/
    self.body unless cut
    self.body[0...cut] if cut
  end

  protected

    def update_edited_at
      self.edited_at = Time.now
    end

end
