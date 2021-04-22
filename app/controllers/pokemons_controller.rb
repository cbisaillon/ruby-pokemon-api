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

    # Check that the parameters are valid
    if page <= 0 or per_page <= 0
      render :nothing => true, :status => :bad_request
      return
    end

    nb_pokemons = Pokemon.count
    offset = (page - 1) * per_page

    # Make sure the offset is valid
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
    @pokemon = get_pokemon_from_request
    if @pokemon == nil
      render :nothing => true, :status => 404
      return
    end

    render json: @pokemon, :status => :ok
  end

  #
  # Create a new pokemon
  def create
    # Make sure required params are present
    required_params = ["number", "name", "type_1_id"]
    required_params.each do |required_param|
      unless params.has_key?(required_param)
        render json: {
          :error => "Missing params"
        }, :status => :bad_request
        return
      end
    end

    # Create the new pokemon
    @pokemon = Pokemon.new(
      number: params[:number],
      name: params[:name],
      type_1_id: params[:type_1_id],
      type_2_id: params[:type_2_id],
      total: params[:total],
      hp: params[:hp],
      attack: params[:attack],
      defense: params[:defense],
      sp_attack: params[:sp_attack],
      sp_defense: params[:sp_defense],
      speed: params[:speed],
      generation: params[:generation],
      is_legendary: params[:is_legendary]
    )

    @pokemon.save!
    render json: @pokemon, :status => :ok
  end

  #
  # Update an existing pokemon
  def update
    @pokemon = get_pokemon_from_request
    if @pokemon == nil
      render :nothing => true, :status => 404
      return
    end

    updatable_columns = [
      "number",
      "name",
      "type_1_id",
      "type_2_id",
      "total",
      "hp",
      "attack",
      "defense",
      "sp_attack",
      "sp_defense",
      "speed",
      "generation",
      "is_legendary"
    ]

    new_attributes = {}

    params.each do |key, value|
      # Make sure the user is not trying to update a
      # column they cannot update
      if updatable_columns.include? key
        new_attributes[key] = value
      end
    end

    @pokemon.update(new_attributes)

    render json: @pokemon, :status => :ok
  end

  #
  # Delete a specific Pokemon instance from the database
  def delete
    @pokemon = get_pokemon_from_request
    if @pokemon == nil
      render :nothing => true, :status => 404
      return
    end

    deleted_pokemon = @pokemon.delete
    render json: deleted_pokemon, :status => :ok
  end

  #
  # Utility method to stay DRY
  # Makes sure the request has the "id" param
  # and that this id is associated with a pokemon
  # @return the pokemon or nil if it cannot find it
  def get_pokemon_from_request()
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
