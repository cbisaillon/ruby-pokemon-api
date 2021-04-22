class TypesController < ApplicationController

  #
  # List all the pokemon types
  def index
    render json: Type.all, :status => :ok
  end

  #
  # Create a new pokemon type
  def create
    unless params.has_key?("type_name")
      render json: {
        :error => "Missing params"
      }, :status => :bad_request
      return
    end

    # Create the new type
    @type = Type.new(
      type_name: params[:type_name]
    )

    @type.save!
    render json: @type, :status => :ok

  end

  #
  # Delete a pokemon type
  def delete
    @type = Type.find_by_id(params[:id])

    # Make sure the type exists
    if @type == nil
      render :nothing => true, :status => 404
      return
    end

    deleted_type = @type.delete
    render json: deleted_type, :status => :ok
  end
end
