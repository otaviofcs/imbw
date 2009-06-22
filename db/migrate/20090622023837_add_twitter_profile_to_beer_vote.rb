class AddTwitterProfileToBeerVote < ActiveRecord::Migration
  def self.up
    add_column :beer_votes, :twitter_profile, :string
  end

  def self.down
    remove_column :beer_votes, :twitter_profile
  end
end
