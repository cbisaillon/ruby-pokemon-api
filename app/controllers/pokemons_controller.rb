class PokemonsController < ApplicationController
  #
  # Fetch the list of pokemons and return it paginated
  def index
    page = 1
    per_page = 10

    if params.has_key?(:page)
      page = params[:page].to_i
    end

    if params.has_key?(:per_page)
      per_page = params[:per_page].to_i
    end

    if page <= 0 or per_page <= 0
      render :nothing => true, :status => :bad_request
      return
    end

    nb_pokemons = Pokemon.count
    offset = (page - 1) * per_page

    if offset >= nb_pokemons
      render :nothing => true, :status => 404
      return
    end

    @pokemons = Pokemon.limit(per_page).offset(offset).order(number: :asc).all
    render json: {
      :page => page,
      :per_page => per_page,
      :has_next => offset + per_page < nb_pokemons,
      :has_prev => offset - per_page >= 0,
      :pokemons => @pokemons,
    }, :status => :ok
  end

  #
  # View a specific pokemon's data
  def view
    @pokemon = make_sure_pokemon_exists
    if @pokemon == nil
      render :nothing => true, :status => 404
      return
    end

    render json: @pokemon, :status => :ok
  end

  #
  # Create a new pokemon
  def create

  end

  #
  # Update an existing pokemon
  def update
    @pokemon = make_sure_pokemon_exists
    if @pokemon == nil
      render :nothing => true, :status => 404
      return
    end

  end

  #
  # Delete a specific Pokemon instance from the database
  def delete
    @pokemon = make_sure_pokemon_exists
    if @pokemon == nil
      render :nothing => true, :status => 404
      return
    end

    deleted_pokemon = @pokemon.delete
    render json: deleted_pokemon, :status => :ok
  end

  #
  # Utility method to stay DRY
  def make_sure_pokemon_exists()
    unless params.has_key?(:id)
      return nil
    end

    @pokemon = Pokemon.find_by_id(params[:id])

    # Make sure the pokemon exists
    if @pokemon == nil
      return nil
    end

    @pokemon
  end
end
