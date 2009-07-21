class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
			t.string :link
			t.string :description
			t.string :title
			t.datetime :linked_at
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
