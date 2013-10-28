class Link < ActiveRecord::Base

  acts_as_taggable_on :tags

  #
  # Options
  #

  # link para o email otaviofcs http://www.google.com/reader/shared/16195098290729456512
  # link para o email osampaio  http://www.google.com/reader/public/atom/user/11310005898312724236/state/com.google/broadcast
  LINK_SOURCE_TYPES = {
    "rplinks" => 'https://links.riopro.com.br/rss.php/otavio',
    "google_reader" => 'http://www.google.com/reader/public/atom/user/16195098290729456512/state/com.google/broadcast'
  }

  cattr_reader :per_page
  @@per_page = 10

  attr_accessible :title, :link, :description, :tag_list, :linked_at, :link_source

  #
  # Association
  #
  has_one :recent_activity, :as => :recentable, :dependent => :destroy


  #
  # Named Scopes
  #
  named_scope :by_id, :order => "id desc"

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


  def text
    self.link
  end


  def self.parse_rss_feed
    feed_parsed = RssParser::RPLinks.run 'links.riopro.com.br',443, LINK_SOURCE_TYPES["rplinks"], true
    Link.create_links_from_feed(feed_parsed[:items])
  end

  def self.parse_diigo_feed
    diigo_url = 'https://www.diigo.com/rss/user/otavio'
    feed_parsed = RssParser::GoogleReader.run 'www.diigo.com', 80, google_reader_url
    Link.create_links_from_feed(feed_parsed[:items])
  end
  

  def self.create_links_from_feed(items)
    itens_created = []
    items.each do |item|
      @link = Link.new(
        :link => item[:link],
        :title => item[:title],
        :description => item[:description],
        :linked_at => item[:pubDate].to_time,
        :link_source => item[:link_source]
      )
      @link.tag_list = item[:categories].join(", ")
      itens_created << @link if @link.save
    end
    itens_created
  end

end
