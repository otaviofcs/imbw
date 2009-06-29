class AddGalleryCodeToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :gallery_code, :string
  end

  def self.down
    remove_column :galleries, :gallery_code
  end
end
