class AttachmentsController < ApplicationController


  # GET /attachments
  #
  # via attachments_path
  #
  # lista de anexos
  def index
    @html_id = params[:html_id]
    @search = Attachment.search(params[:search])
    @attachments = @search.paginate(:page => params[:page])
  end


end
