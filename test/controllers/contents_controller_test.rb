require "test_helper"

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "shows content detail page" do
    get community_content_path("bryght", contents(:intro_ruby))
    assert_response :success
    assert_select "h1", text: contents(:intro_ruby).title
  end

  test "404 for unknown content" do
    get community_content_path("bryght", 0)
    assert_response :not_found
  end
end
