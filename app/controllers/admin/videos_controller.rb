class Admin::VideosController < AdminController

  def index
    @videos = Video.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end

  def new
    @video = Video.new
  end

  def create
    @video = current_user.videos.build(params[:video])
    if @video.save
      flash[:notice] = 'Video enviado'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to :action => 'index'
  end
end
