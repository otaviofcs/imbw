class AddPriceAndVolumeTypeToBeerVotes < ActiveRecord::Migration
  def self.up
    add_column :beer_votes, :price, :decimal, :precision => 14, :scale => 2
    add_column :beer_votes, :volume_type, :string
  end

  def self.down
    remove_column :beer_votes, :price
    remove_column :beer_votes, :volume_type
  end
end
