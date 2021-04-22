require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/pokemons", params: {page: 1, per_page: 2}
    result = @response.parsed_body
    assert_response :success
    assert_equal 1, result["page"]
    assert_equal 2, result["per_page"]
    assert_equal true, result["has_next"]
    assert_equal false, result["has_prev"]
    assert_equal 2, result["pokemons"].length
    assert_equal 1, result["pokemons"][0]["number"]
    assert_equal 2, result["pokemons"][1]["number"]
  end

  test "should get index last page" do
    get "/pokemons", params: {page: 50, per_page: 5}
    result = @response.parsed_body
    assert_response :success
    assert_equal 50, result["page"]
    assert_equal 5, result["per_page"]
    assert_equal false, result["has_next"]
    assert_equal true, result["has_prev"]
    assert_equal 5, result["pokemons"].length
  end

  test "should error on invalid per_page" do
    get "/pokemons", params: {page: 1, per_page: -5}
    result = @response.parsed_body
    assert_response 400
    assert_nil result["page"]
    assert_nil result["per_page"]
    assert_nil result["has_next"]
    assert_nil result["has_prev"]
    assert_nil result["pokemons"]
  end

  test "should error on invalid page" do
    get "/pokemons", params: {page: -10, per_page: 5}
    result = @response.parsed_body
    assert_response 400
    assert_nil result["page"]
    assert_nil result["per_page"]
    assert_nil result["has_next"]
    assert_nil result["has_prev"]
    assert_nil result["pokemons"]
  end

  test "should 404 on too big page" do
    get "/pokemons", params: {page: 50000, per_page: 5}
    result = @response.parsed_body
    assert_response :missing
    assert_nil result["page"]
    assert_nil result["per_page"]
    assert_nil result["has_next"]
    assert_nil result["has_prev"]
    assert_nil result["pokemons"]
  end

  test "should not 404 on too big page edge case" do
    get "/pokemons", params: {page: 250, per_page: 1}
    result = @response.parsed_body
    assert_response :success
    assert_equal 250, result["page"]
    assert_equal 1, result["per_page"]
    assert_equal false, result["has_next"]
    assert_equal true, result["has_prev"]
    assert_equal 1, result["pokemons"].length
  end

end
