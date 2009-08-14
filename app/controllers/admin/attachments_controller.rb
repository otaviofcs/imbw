class Admin::AttachmentsController < ApplicationController


  # GET /admin/attachments
  # Via: admin_attachments_path
  # Disponível: [admin]
  #
  # lista de attachments
  def index
    @attachments = current_user.attachments.paginate( :page => params[:page] )
    @page_title = "Lista de Attachments"
  end

  # GET /admin/attachments/new
  # Via: new_admin_attachment_path
  # Disponível: [admin]
  #
  # lista de attachments
  def new
    @attachment = current_user.attachments.build
  end

  # POST /admin/attachments
  # Via: admin_attachments_path
  # Available: [administradores]
  #
  # Criar novo attachment
  def create
    @attachment = current_user.attachments.build(params[:attachment])
    if @attachment.save
      flash[:success] = "Criado com sucesso!"
      redirect_to admin_attachments_path
    else
      @page_title = "Novo Anexo"
      render :action => 'new'
    end
  end

  # DELETE /admin/attachments/1
  # Via: admin_attachment_path(1)
  # Disponível: [admin]
  #
  # apaga attachment
  def destroy
    @attachment = current_user.attachments.find params[:id]
    @attachment.destroy
    flash[:success] = "Anexo apagado com sucesso"
    redirect_to admin_attachments_path
  end

end
