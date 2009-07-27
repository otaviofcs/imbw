class Note < ActiveRecord::Base

  acts_as_taggable_on :tags

  attr_accessible :note, :note_taked_at, :twit_id

  #
  # Named Scopes
  #
  
  named_scope :tagged_with_on_tags, lambda { |tag|
    # match_all é para que as condições sejam associativas.
    # ou seja, o objeto tem que ter todas as tags descritas
    options = { :on => :tags, :match_all => true }
    find_options_for_find_tagged_with(tag, options)
  }

  def self.create_notes_from_twitter
    @notes = []
    @twitter_updates = Twitter::Search.new.from("otaviofcs")

    @twitter_updates.each do |twit|
      note = Note.create_one_note twit
      @notes << note if note.save
    end
  end

  def self.create_one_note(twit)
    note = Note.new :note => twit.text, :note_taked_at => twit.created_at.to_time, :twit_id => twit.id
    hashtags = twit.text.scan(/#([a-z0-9_]+)/i)
    note.tag_list = hashtags.each{ |tag| tag }.join(", ")
    note
  end

end
