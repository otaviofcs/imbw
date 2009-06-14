class AddHashToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :galery_hash, :string
  end

  def self.down
    remove_column :galleries, :galery_hash
  end
end
