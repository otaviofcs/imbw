class BeerVote < ActiveRecord::Base

  AVAILABLE_FIELDS = {
    "bv" => :vote,
    "vote" => :vote,
    "bt" => :title,
    "title" => :title,
    "bc" => :country,
    "country" => :title,
    "bd" => :comment,
    "description" => :comment
  }

  #
  # Validations
  #

  validates_presence_of :title

  validates_presence_of :twitter_profile

  validates_presence_of :commented_at

  #
  def self.parse_vote(vote_description)
    parsed = {}

    initial_value = 0
    final_value = 0
    tag_name = ""

    hashtags = vote_description.scan(/#([a-z0-9_]+)/i)
    hashtags
    hashtags.each do |tag|
      final_value = ( vote_description =~ /##{tag}/i )
      parsed = parsed.merge( { tag_name => vote_description[initial_value..final_value - 1] } ) if initial_value > 0
      tag_name = tag.to_s
      initial_value = final_value + tag.to_s.size + 1
    end

    parsed
  end

end
