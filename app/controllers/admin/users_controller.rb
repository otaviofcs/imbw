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



end
