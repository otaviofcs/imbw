class Admin::SessionsController < AdminController

  skip_before_filter :user_required, :only => [:new, :create]

  # GET /admin/session/new
  # GET /login
  # GET /login?return_to=teste
  # Via: new_admin_session_path
  # Via: admin_login_path
  # Disponível: [todos]
  #
  # Mostra formulário de login de usuário. Pode receber parâmetro chamado
  # return_to para encaminhar usuário após o login bem sucedido.
  def new
    @page_title = 'Fazer Login'
    @user_session = UserSession.new
  end

  # POST /admin/session
  # Via: admin_session_path
  # Disponível: [todos]
  #
  # Logs in the specified user. Redirects to root_path or to the previous
  # page that required authentication, if successful.
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = " login bem sucedido!"
      redirect_back_or_default admin_root_path
    else
      @page_title = 'Fazer Login'
      note_failed_signin
      render :action => :new
    end
  end

  # GET /logout
  # DELETE /admin/session
  # Via: admin_logout_path
  # Via: admin_session_path
  # Available: supper_logged_in
  #
  # Logs out the current user and redirects to login_path.
  def destroy
    current_user_session.destroy
    flash[:notice] = "Você não está mais logado"
    redirect_back_or_default(login_path)
  end

  protected

    # Track failed login attempts
    def note_failed_signin
      flash[:error] = "Não foi possível fazer login como '#{params[:user_session][:login]}'"
      logger.warn "Failed  login for '#{params[:user_session][:login]}' from #{request.remote_ip} at #{Time.current}"
    end

end
