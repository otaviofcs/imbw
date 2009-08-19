class LinkObserver < ActiveRecord::Observer

  def after_create(link)
    @recent_activity = RecentActivity.new(:recentable => link)
    @recent_activity.save
    true
  end

end
