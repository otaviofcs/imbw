class NotesController < ApplicationController

  # Requer um +current_user+ setado.
  before_filter :user_required, :only => [:destroy]

  # GET /notes
  # GET /
  # Via: notes_path
  # Disponivel: [todos]
  #
  # lista de notas no twitter
  def index
    params_search = { "order" => :descend_by_note_taked_at }
    params_search = params_search.merge(params[:search]) if params[:search]
    @search = Note.search params_search
    @notes = @search.paginate(:page => params[:page])
    @page_title = "Anotações feitas no Twitter"
    @tags = Note.tag_counts :limit => 50, :order => 'tags.name'
  end

  # DELETE /notes/1
  # Via: note_path(1)
  # Disponível: [logados]
  #
  # Apaga uma anotação
  def destroy
    @note = Note.find params[:id]
    if @note.destroy
      flash[:success] = "Anotação feita em #{l(@note.note_taked_at)} destruida com sucesso!"
    end
    redirect_to notes_path
  end

end
