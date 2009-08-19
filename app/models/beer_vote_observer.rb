class BeerVoteObserver < ActiveRecord::Observer

  def after_create(beer_vote)
    @recent_activity = RecentActivity.new(:recentable => beer_vote)
    @recent_activity.save
    true
  end

end
