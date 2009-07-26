class Link < ActiveRecord::Base

  acts_as_taggable_on :tags

  #
  # Options
  #
  cattr_reader :per_page
  @@per_page = 10

  attr_accessible :title, :link, :description, :tag_list, :linked_at

  #
  # Named Scopes
  #

  named_scope :tagged_with_on_tags, lambda { |tag|
    # match_all é para que as condições sejam associativas.
    # ou seja, o objeto tem que ter todas as tags descritas
    options = { :on => :tags, :match_all => true }
    find_options_for_find_tagged_with(tag, options)
  }

  #
  # Validations
  #
  
  validates_presence_of :title
  validates_presence_of :linked_at
  validates_presence_of :link
  validates_uniqueness_of :link

  def self.parse_rss_feed
    feed_parsed = RssParser::WithReXML.run 'links.riopro.com.br',443,'https://links.riopro.com.br/rss.php/otavio', true
    Link.create_links_from_feed(feed_parsed[:items])
  end

  def self.create_links_from_feed(items)
    itens_created = []
    items.each do |item|
      @link = Link.new(
        :link => item[:link],
        :title => item[:title],
        :description => item[:description],
        :linked_at => item[:pubDate].to_time
      )
      @link.tag_list = item[:categories].join(", ")
      itens_created << @link if @link.save
    end
    itens_created
  end

end
