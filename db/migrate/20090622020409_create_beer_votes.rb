class CreateBeerVotes < ActiveRecord::Migration
  def self.up
    create_table :beer_votes do |t|
      t.string  :title
      t.float   :vote
      t.string  :description
      t.string  :country
      t.timestamps
    end
  end

  def self.down
    drop_table :beer_votes
  end
end
