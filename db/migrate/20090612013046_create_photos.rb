class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :user_id
      t.integer :gallery_id
      t.string  :title

      t.integer :size
      t.string  :content_type
      t.string  :filename
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
