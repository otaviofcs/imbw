class RenameGalleryCodeField < ActiveRecord::Migration
  def self.up
    remove_column :galleries, :gallery_code
    add_column :galleries, :public_code, :string
  end

  def self.down
    remove_column :galleries, :public_code
    add_column :galleries, :gallery_code, :string
  end
end
