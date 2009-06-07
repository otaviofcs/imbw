class UsersController < ApplicationController


  # GET /users/1
  # Via: user_path(1)
  # Disponível: [todos]
  #
  # um usuário
  def show
    @user = User.find params[:id]
    @page_title = "Usuário ##{@user.id}"
  end

end
