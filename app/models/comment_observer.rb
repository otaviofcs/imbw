class CommentObserver < ActiveRecord::Observer

  def after_create(comment)
    @recent_activity = RecentActivity.new(:recentable => comment)
    @recent_activity.save
    true
  end
end
