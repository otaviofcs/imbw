class RemoveBodyHtmlFieldFromPost < ActiveRecord::Migration
  def self.up
    remove_column :posts, :body_html
  end

  def self.down
    add_column :posts, :body_html, :text
  end
end
