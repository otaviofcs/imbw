class BeerVote < ActiveRecord::Base


  #
  # Validations
  #

  validates_presence_of :title

  validates_presence_of :twitter_profile

  validates_presence_of :commented_at

end
