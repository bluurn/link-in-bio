require "test_helper"

class ManageControllerTest < ActionDispatch::IntegrationTest
  test "shows manage page" do
    get manage_path("bryght")
    assert_response :success
    assert_select "h1", text: "Bryght Community"
  end

  test "404 for unknown community" do
    get manage_path("nonexistent")
    assert_response :not_found
  end

  test "search filters catalog by title" do
    get manage_path("bryght", q: "introduction to ruby")
    assert_response :success
    assert_select "turbo-frame#catalog" do
      assert_select "p", text: /Introduction to Ruby/i
    end
  end

  test "kind filter applied" do
    get manage_path("bryght", kind: "event")
    assert_response :success
    assert_select "turbo-frame#catalog" do
      assert_select "p", text: /Rails Summit/i
    end
  end
end
