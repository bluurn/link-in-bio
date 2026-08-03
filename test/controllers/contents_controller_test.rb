require "test_helper"

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "shows content detail page via slug" do
    get community_content_path("bryght", contents(:intro_ruby))
    assert_response :success
    assert_select "h1", text: contents(:intro_ruby).title
  end

  test "404 for unknown content slug" do
    get community_content_path("bryght", "nonexistent-slug")
    assert_response :not_found
  end

  test "404 when community slug does not exist" do
    get community_content_path("nonexistent", contents(:intro_ruby))
    assert_response :not_found
  end
end
