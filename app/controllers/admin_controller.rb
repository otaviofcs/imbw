class AdminController < ApplicationController
  
  # Requer um +current_user+ setado para a área administrativa
  before_filter :user_required

end
