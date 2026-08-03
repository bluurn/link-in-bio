require "test_helper"

class CommunitiesControllerTest < ActionDispatch::IntegrationTest
  test "shows public page for valid slug" do
    get community_path("bryght")
    assert_response :success
    assert_select "h1", text: "Bryght Community"
  end

  test "404 for unknown slug" do
    get community_path("nonexistent")
    assert_response :not_found
  end
end
