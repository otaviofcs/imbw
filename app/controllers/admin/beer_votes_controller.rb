class Admin::BeerVotesController < AdminController

  # GET /beer_votes
  # Via: admin_beer_votes_path
  # Disponível: [todos]
  #
  # lista de beer_votes
  def index
    search_params = {"order" => :descend_by_commented_at}
    search_params = search_params.merge(params[:search]) if params[:search]
    @search = BeerVote.search(search_params)
    @beer_votes = @search.paginate :page => params[:page]
    @page_title = "Cervejas que eu bebi, hoje e ontem - I Might be W.R.O.N.G."
    @user = User.first
  end

  # GET /beer_votes/new
  # Via: admin_new_beer_vote_path
  # Disponível: [logados]
  #
  # novo voto em cervejas
  def new
    @beer_vote = BeerVote.new
    @page_title = "Nova Cerveja"
  end

  # GET /beer_votes/1/edit
  # Via: admin_edit_beer_vote_path(1)
  # Disponível: [logados]
  #
  # editando voto em cervejas
  def edit
    @beer_vote = BeerVote.new
    @page_title = "Editando Cerveja"
  end

  # POST /beer_votes
  # Via: admin_beer_votes_path
  # Disponível: [logados]
  #
  # criando voto em cerveja
  def create
    @beer_vote = BeerVote.build(params[:beer_vote])
    if @beer_vote.save
      flash[:success] = "sucesso"
    end
    redirect_to beer_votes_path
  end
  
  # PUT /beer_votes/1
  # Via: admin_beer_vote_path(1)
  # Disponível: [logados]
  #
  # atualizando voto em cerveja
  def update
    @beer_vote = BeerVote.find params[:id]
    if @beer_vote.update_attributes(params[:beer_vote])
      flash[:success] = "salvo com sucesso!"
    end
    redirect_to beer_votes_path
  end

  # DELETE /beer_votes/1
  # Via: admin_beer_vote_path(1)
  # Disponível: [logados]
  #
  # Apaga um voto sobre cerveja
  def destroy
    @beer_vote = BeerVote.find params[:id]
    if @beer_vote.destroy
      flash[:success] = "Voto em #{@beer_vote.title} destruido com sucesso!"
    end
    redirect_to beer_votes_path
  end

end
