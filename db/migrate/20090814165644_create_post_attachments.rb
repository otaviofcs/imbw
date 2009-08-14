class CreatePostAttachments < ActiveRecord::Migration
  def self.up
    create_table :post_attachments do |t|
      t.integer :user_id
      t.string  :title
      t.integer :size
      t.string  :content_type
      t.string  :filename
      t.integer :height
      t.integer :width
      t.integer :photos, :parent_id
      t.string  :photos, :thumbnail
      t.timestamps
    end
  end

  def self.down
    drop_table :post_attachments
  end
end
