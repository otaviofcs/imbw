class NotesController < ApplicationController

  # GET /notes
  # GET /
  # Via: notes_path
  # Disponivel: [todos]
  #
  # lista de notas no twitter
  def index
    params_search = { "order" => :descend_note_taked_at }
    params_search = params_search.merge(params[:search]) if params[:search]
    @search = Note.search params_search
    @notes = @search.paginate(:page => params[:page])
    @page_title = "Anotações feitas no Twitter"
    @tags = Note.tag_counts :limit => 10
  end

end
