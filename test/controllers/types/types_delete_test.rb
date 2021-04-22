require "test_helper"

class TypesDeleteTest < ActionDispatch::IntegrationTest
  test "should delete type" do

    type_to_delete = Type.new(type_name: "Wood")
    type_to_delete.save!
    post "/types/#{type_to_delete.id}/delete"

    result = @response.parsed_body
    assert_response :success

    assert_equal 3, result["id"]
    assert_equal "Wood", result["type_name"]

    # Verify that the type has been removed from the database
    assert_nil Type.find_by_id(result["id"])
  end

  test "should 404 on id not existant" do
    post "/types/231423/delete"
    assert_response :missing
  end

end
