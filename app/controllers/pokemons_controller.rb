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

    @pokemons = Pokemon.limit(per_page).offset((page - 1) * per_page).all
    render json: {
      :page => page,
      :per_page => per_page,
      :has_next => true,
      :has_prev => true,
      :pokemons => @pokemons,
    }
  end

  def create

  end

  def edit

  end

  def delete

  end
end
