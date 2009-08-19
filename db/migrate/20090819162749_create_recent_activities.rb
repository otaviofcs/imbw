class CreateRecentActivities < ActiveRecord::Migration
  def self.up
    create_table :recent_activities do |t|
      t.string  :recentable_type
      t.integer :recentable_id
      t.timestamps
    end
  end

  def self.down
    drop_table :recent_activities
  end
end
