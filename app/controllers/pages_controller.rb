class PagesController < ApplicationController

  # GET /pages
  # GET /pages.rss
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

  # GET /pages/mobile
  # GET /pages/mobile/true
  # GET /pages/mobile/false
  # GET /pages/mobile?id=true
  def mobile
    session[:mobile_view] = false unless params[:id]
    session[:mobile_view] = params[:id] if params[:id]
    redirect_to pages_path
  end
end
