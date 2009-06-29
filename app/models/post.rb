class Post < ActiveRecord::Base

  acts_as_textiled :body

  acts_as_taggable_on :tags

  #
  # Association
  #

  belongs_to :user

  named_scope :available, :conditions => ["posts.active = ? and (not posts.published_at is null)", true]
  named_scope :by_id, :order => "id desc"

  cattr_reader :per_page
  @@per_page = 10

  before_save :update_edited_at

  #
  # Validations
  #

  validates_presence_of :user_id

  validates_presence_of :title

  validates_presence_of :body
  validates_length_of   :body, :minimum => 20

  validates_presence_of :edited_at

  protected

    def update_edited_at
      self.edited_at = Time.now
    end

end
