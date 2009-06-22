class AddCommentedAtToBeerVote < ActiveRecord::Migration
  def self.up
    add_column  :beer_votes, :commented_at, :datetime
  end

  def self.down
    remove_column  :beer_votes, :commented_at
  end
end
