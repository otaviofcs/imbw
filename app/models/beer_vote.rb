class BeerVote < ActiveRecord::Base

  usar_como_dinheiro :price

  attr_accessible :title, :vote, :comment, :country, :twitter_profile, :commented_at, :price, :volume_type

  named_scope :last_commented_at, :order => "commented_at desc"

  named_scope :by_id, :order => "id desc"

  #
  # Association
  #
  has_one :recent_activity, :as => :recentable, :dependent => :destroy

  #
  # Constants
  #

  POSSIBLE_VOLUME_TYPES = %w( 275ml 300ml 330ml 500ml 600ml 750ml 1lt 2lt 5lt)

  #
  # Option
  #

  cattr_reader :per_page
  @@per_page = 10


  FIELDS_ALIASES = {
    "bv" => :vote,
    "vote" => :vote,
    "bt" => :title,
    "title" => :title,
    "bc" => :country,
    "country" => :country,
    "bd" => :comment,
    "description" => :comment
  }

  #
  # Validations
  #

  validates_presence_of :title
  validates_presence_of :twitter_profile
  validates_presence_of :commented_at
  validates_inclusion_of :volume_type,
    :in => POSSIBLE_VOLUME_TYPES,
    :allow_blank => true
  validates_numericality_of :price,
    :greater_than => 0.0,
    :allow_blank => true

  def text
    self.comment
  end

  def self.last_updated_at
    vote = BeerVote.find(:first, :order => 'beer_votes.commented_at desc')
    if vote
      vote.commented_at
    else
      nil
    end
  end

  # Searchs for the most recent updates on Twitter. Avoids
  # repetition based on last updated beer vote
  def self.fetch_and_create_votes
    votes_created = 0
    last_updated_at = BeerVote.last_updated_at
    # search_term = "#beer since:#{last_updated_at.to_date.to_s}"
    search_term = "#beer"
    @twitter_updates = Twitter::Search.new(search_term).from('otaviofcs')
    @twitter_updates.each do |twitter_update|
      if twitter_update.created_at.to_time > last_updated_at
        result = BeerVote.create_one_vote(twitter_update)
        votes_created += 1 if result == true
        logger.debug "#{result.errors.inspect} #{twitter_update.text}" unless result == true
      end
    end if @twitter_updates
    "criados #{votes_created} votos"
  end

  def self.create_one_vote(twitter_update)
    @beer_vote = BeerVote.new(:twitter_profile => twitter_update.from_user, :commented_at => twitter_update.created_at.to_datetime)
    fields = BeerVote.parse_vote twitter_update.text
    fields.each do |key, value|
      @beer_vote.send "#{BeerVote::FIELDS_ALIASES[key]}=".to_sym, value if BeerVote::FIELDS_ALIASES[key]
    end
    if @beer_vote.save
      true
    else
      @beer_vote
    end
  end

  # recebe um comentário usando hashtags e parseia para um hash
  def self.parse_vote(vote_description)
    parsed = {}

    initial_value = 0
    final_value = 0
    tag_name = ""

    hashtags = vote_description.scan(/%([a-z0-9_]+)/i)
    hashtags.each do |tag|
      final_value = ( vote_description =~ /%#{tag}/i )
      parsed = parsed.merge( { tag_name => vote_description[initial_value..final_value - 1].strip } ) if initial_value > 0
      tag_name = tag.to_s
      initial_value = final_value + tag.to_s.size + 1
    end
    parsed = parsed.merge( { tag_name => vote_description[initial_value..vote_description.size].strip } ) if initial_value < vote_description.size
    parsed
  end

end
