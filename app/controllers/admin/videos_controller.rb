class Admin::VideosController < AdminController

  def index
    @videos = current_user.videos.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end

  def new
    @video = Video.new
  end


  def edit
    @video = current_user.videos.find(params[:id])
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


  def update
    @video = current_user.videos.find(params[:id])
    if @video.update_attributes(params[:video])
      flash[:notice] = 'Video atualizado com sucesso'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @video = current_user.videos.find(params[:id])
    @video.destroy
    redirect_to :action => 'index'
  end
end
