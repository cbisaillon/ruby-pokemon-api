require "test_helper"

class PokemonsUpdateTest < ActionDispatch::IntegrationTest
  test "should update pokemon" do
    pokemon_to_update = Pokemon.first

    post "/pokemons/#{pokemon_to_update.id}/update", params: {
      number: 412341234444,
      name: "FireBulba",
      type_1_id: 2,
    }
    assert_response :success

    # Check that model was updated in db
    pokemon = Pokemon.find(pokemon_to_update.id)
    assert_equal 412341234444, pokemon.number
    assert_equal "FireBulba", pokemon.name
    assert_equal "Water", pokemon.type_1.type_name
  end

  test "should error on update pokemon id" do
    pokemon_to_update = Pokemon.first

    post "/pokemons/#{pokemon_to_update.id}/update", params: {
      id: 444,
      number: 412341234444,
      name: "FireBulba",
      type_1_id: 2,
    }
    assert_response 200

    # Make sure id has not changed
    pokemon = Pokemon.find(pokemon_to_update.id)
    assert_not_equal 444, pokemon.id
  end

end
