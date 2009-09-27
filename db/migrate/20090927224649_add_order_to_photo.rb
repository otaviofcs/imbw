class AddOrderToPhoto < ActiveRecord::Migration
  def self.up
    add_column  :photos, :relevance, :integer, :default => 50
  end

  def self.down
    remove_column  :photos, :relevance
  end
end
