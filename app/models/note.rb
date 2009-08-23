class Note < ActiveRecord::Base

  acts_as_taggable_on :tags

  #
  # Options
  #
  cattr_reader :per_page
  @@per_page = 20

  attr_accessible :note, :note_taked_at, :twit_id

  #
  # Association
  #
  has_one :recent_activity, :as => :recentable, :dependent => :destroy


  #
  # Validations
  #

  validates_presence_of :twit_id
  validates_uniqueness_of :twit_id

  validates_presence_of :note_taked_at
  validates_presence_of :note


  #
  # Named Scopes
  #
  named_scope :by_id, :order => "id desc"

  named_scope :tagged_with_on_tags, lambda { |tag|
    # match_all é para que as condições sejam associativas.
    # ou seja, o objeto tem que ter todas as tags descritas
    options = { :on => :tags, :match_all => true }
    find_options_for_find_tagged_with(tag, options)
  }

  def title
    "Twit http://twitter.com/otaviofcs/status/#{self.twit_id}"
  end

  def text
    self.note
  end

  def self.create_notes_from_twitter
    @notes = []
    @twitter_updates = Twitter::Search.new.from("otaviofcs")

    @twitter_updates.each do |twit|
      note = Note.create_one_note twit
      @notes << note if note.save
    end
    @notes
  end

  def self.create_one_note(twit)
    note = Note.new :note => twit.text, :note_taked_at => twit.created_at.to_time, :twit_id => twit.id
    hashtags = twit.text.scan(/#([a-z0-9_]+)/i)
    note.tag_list = hashtags.each{ |tag| tag }.join(", ")
    note
  end

end
