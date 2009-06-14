class AddHashToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :gallery_hash, :string
  end

  def self.down
    remove_column :galleries, :gallery_hash
  end
end
