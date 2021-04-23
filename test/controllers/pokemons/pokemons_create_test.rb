require "test_helper"

class PokemonsCreateTest < ActionDispatch::IntegrationTest
  test "should create pokemon" do
    post "/pokemons/create", params: {
      number: 412341234444,
      name: "FireBulba",
      type_1_id: 1,
      type_2_id: nil
    }
    assert_response :success

    # Check that latest result in database match
    # provided params

    pokemon = Pokemon.last
    assert_equal 412341234444, pokemon.number
    assert_equal "FireBulba", pokemon.name
    assert_equal "Fire", pokemon.type_1.type_name
  end

  test "should error when missing params" do
    post "/pokemons/create"
    result = @response.parsed_body
    assert_response 400
    assert_not_nil result["error"]
    assert_equal "Missing params", result["error"]
  end

  test "should error on non unique" do
    pokemon = Pokemon.first

    post "/pokemons/create", params: {
      number: pokemon.number,
      name: "FireBulba",
      type_1_id: 1,
    }
    result = @response.parsed_body
    assert_response 400
    assert_not_nil result["error"]
    assert_equal "Record not unique !", result["error"]
  end

end
