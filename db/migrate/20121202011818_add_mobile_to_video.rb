class AddMobileToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :mobile, :boolean, :default => false
  end

  def self.down
    remove_column :videos, :mobile
  end
end
