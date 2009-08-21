class PagesController < ApplicationController

  # GET /pages
  # GET /
  # Via: pages_path
  # Disponível: [todos]
  #
  # página index do site
  def index
    @page_title = "página inicial - home"
    @filter = { :order => 'descend_by_id' }
    @filter = @filter.merge(params[:search]) if params[:search]
    @search = RecentActivity.search(@filter)
    @recent_activities = @search.paginate(:page => params[:page])
  end
end
