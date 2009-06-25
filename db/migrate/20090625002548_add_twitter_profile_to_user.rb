class AddTwitterProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_profile, :string
    add_column :users, :twitter_profile_image, :string
  end

  def self.down
    remove_column :users, :twitter_profile
    remove_column :users, :twitter_profile_image
  end
end
