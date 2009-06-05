class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string   :title,                                              :null => false
      t.text     :body,                                               :null => false
      t.text     :body_html,                                          :null => false
      t.boolean  :active,          :default => true,                  :null => false
      t.datetime :published_at
      t.datetime :edited_at,                                          :null => false
      t.timestamps
    end
    add_index :posts, :published_at

  end

  def self.down
    drop_table :posts
  end
end
