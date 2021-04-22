require "test_helper"

class TypeIndexTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/types"
    result = @response.parsed_body
    assert_response :success
    assert_equal 2, result.length
    assert_equal "Fire", result[0]["type_name"]
    assert_equal "Water", result[1]["type_name"]
  end
end
