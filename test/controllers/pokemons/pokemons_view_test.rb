require "test_helper"

class PokemonsViewTest < ActionDispatch::IntegrationTest
  test "should view pokemon" do
    get "/pokemons/2205286"
    result = @response.parsed_body
    assert_response :success
    assert_equal 2205286, result["id"]
    assert_equal 131, result["number"]
    assert_equal "pokemon_131", result["name"]
  end

  test "should view pokemon 2" do
    get "/pokemons/3393183"
    result = @response.parsed_body
    assert_response :success
    assert_equal 3393183, result["id"]
    assert_equal 122, result["number"]
    assert_equal "pokemon_122", result["name"]
  end

  test "should 404 on id not existant" do
    get "/pokemons/1"
    assert_response :missing
  end

end
