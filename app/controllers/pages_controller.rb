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

  # GET /pages/musica
  # Via: musica_pages_path
  # Disponível: [todos]
  #
  # Músicas recentes
  def musica
    APP_CONFIG['last_fm_api_key']
  end

  # GET /pages/mobile/1 # true
  # GET /pages/mobile/0 # false
  # GET /pages/mobile?id=1
  # GET mobile_pages_path(:id => 1)
  #
  # alterna entre versão mobile e versão não mobile
  def mobile
    if params[:id]
      if params[:id] == "1"
        session[:mobile_view] = true
      else
        session[:mobile_view] = false
      end
    end
    redirect_to pages_path
  end
end
