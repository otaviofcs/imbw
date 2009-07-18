class AddHashFieldToPhotos < ActiveRecord::Migration
  def self.up
    add_column  :photos, :photo_hash, :string
  end

  def self.down
    remove_column  :photos, :photo_hash
  end
end
