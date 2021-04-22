require "test_helper"

class TypesCreateTest < ActionDispatch::IntegrationTest
  test "should create type" do
    post "/types/create", params: {
      type_name: "Wood",
    }
    assert_response :success

    # Check that latest result in database match
    # provided params

    type = Type.last
    assert_equal "Wood", type.type_name
  end

  test "should error when missing params" do
    post "/types/create"
    result = @response.parsed_body
    assert_response 400
    assert_not_nil result["error"]
    assert_equal "Missing params", result["error"]
  end

end
