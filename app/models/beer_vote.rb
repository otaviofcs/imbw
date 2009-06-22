class BeerVote < ActiveRecord::Base


  #
  # Validations
  #

  validates_presence_of :title

end
