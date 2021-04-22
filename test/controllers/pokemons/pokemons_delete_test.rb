require "test_helper"

class PokemonsDeleteTest < ActionDispatch::IntegrationTest
  test "should delete pokemon" do

    pokemon_to_delete = Pokemon.first
    post "/pokemons/#{pokemon_to_delete.id}/delete"

    result = @response.parsed_body
    assert_response :success

    assert_equal 2205286, result["id"]
    assert_equal 131, result["number"]
    assert_equal "pokemon_131", result["name"]

    # Verify that pokemon has been removed from database
    assert_nil Pokemon.find_by_id(result["id"])
  end

  test "should 404 on id not existant" do
    post "/pokemons/1/delete"
    assert_response :missing
  end

end
