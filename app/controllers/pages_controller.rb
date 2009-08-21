class PagesController < ApplicationController

  # GET /pages
  # GET /
  # Via: pages_path
  # Disponível: [todos]
  #
  # página index do site
  def index
    @page_title = "página inicial - home"
    @recent_activities = RecentActivity.find(:all, :order => 'id desc').paginate(:page => params[:page])
  end
end
