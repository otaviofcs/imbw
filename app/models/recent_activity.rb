class RecentActivity < ActiveRecord::Base

  #
  # Associations
  #

  belongs_to :recentable, :polymorphic => true

  #
  # Validations
  #
  validates_presence_of :recentable_type
  validates_presence_of :recentable_id

  #
  # Options
  #
  attr_accessible :recentable, :recentable_type, :recentable_id

end
