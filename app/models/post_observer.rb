class PostObserver < ActiveRecord::Observer

  def after_create(post)
    if post.published_at
      @recent_activity = RecentActivity.new(:recentable => post)
      @recent_activity.save
    end
    true
  end

  def after_update(post)
    if post.published_at_changed? && post.published_at
      @recent_activity = RecentActivity.new(:recentable => post)
      @recent_activity.save
    end
    true
  end

end
