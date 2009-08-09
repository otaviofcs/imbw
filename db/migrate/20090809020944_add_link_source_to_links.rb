class AddLinkSourceToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :link_source, :string
    @links = Link.all
    @links.each do |link|
      link.link_source = "rplinks"
      link.save
    end
  end

  def self.down
    remove_column :links, :link_source
  end
end
