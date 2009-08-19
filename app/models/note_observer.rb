class NoteObserver < ActiveRecord::Observer

  def after_create(note)
    @recent_activity = RecentActivity.new(:recentable => note)
    @recent_activity.save
    true
  end
end
