class Admin::UsersController < AdminController

  
  # GET /admin/users
  # Via: admin_users_path
  # Disponível: [admin]
  #
  # lista de usuários
  def index
    @users = User.all
    @page_title = "Lista de Usuários"
  end

  # GET /admin/users/new
  # Via: new_admin_users_path
  # Disponível: [admin]
  #
  # novo user
  def new
    @user = User.new
    @page_title = "Novo Usuário"
  end

  # GET /admin/users/1/edit
  # Via: edit_admin_users_path(1)
  # Disponível: [admin]
  #
  # editando user
  def edit
    @user = User.find params[:id]
    @page_title = "Editando User ##{@user.id}"
  end

  # POST /admin/users
  # Via: admin_user_path
  # Available: [administradores]
  #
  # Criar novo usuário
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Usuário criado com sucesso."
      redirect_to admin_users_path
    else
      @page_title = "Novo Usuário"
      render :action => 'new'
    end
  end

  # PUT /admin/users/1
  # Via: admin_users_path
  # Disponível: [admin]
  #
  # Atualiza dados do usuário
  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      flash[:success] = "Usuário alterado com sucesso"
      redirect_to admin_users_path
    else
      @page_title = "Editando User ##{@user.id}"
      render :action => 'edit'
    end
  end

end
