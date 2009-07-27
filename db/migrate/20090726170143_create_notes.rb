class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.string    :note
      t.datetime  :note_taked_at
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
