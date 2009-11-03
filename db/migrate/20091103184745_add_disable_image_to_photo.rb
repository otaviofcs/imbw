class AddDisableImageToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :disable, :integer
    @photos = Photo.all
    @photos.each do |photo|
      photo.disable = 0
      photo.save
    end
  end

  def self.down
    remove_column :photos, :disable
  end
end
