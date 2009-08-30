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

  # GET /pages/mobile/true
  # GET /pages/mobile/false
  # GET /pages/mobile?id=true
  # GET mobile_pages_path
  #
  # alterna entre versão mobile e versão não mobile
  def mobile
    if params[:id]
      if params[:id] == "true"
        session[:mobile_view] = true
      else
        session[:mobile_view] = false
      end
    end
    redirect_to pages_path
  end
end
