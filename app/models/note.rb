class Note < ActiveRecord::Base

  acts_as_taggable_on :tags

  attr_accessible :note, :note_taked_at, :twit_id

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
