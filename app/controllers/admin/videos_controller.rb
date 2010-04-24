class Admin::VideosController < AdminController

  def index
    @videos = Video.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    @video.user = @current_user
    if @video.save
      flash[:notice] = 'Video enviado'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def destroys
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to :action => 'index'
  end
end
