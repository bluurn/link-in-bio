require "test_helper"

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  test "adding a content creates a selection and redirects" do
    assert_difference "communities(:bryght).selections.count" do
      post selections_path("bryght"), params: { content_id: contents(:jazz_playlist).id }
    end
    assert_redirected_to manage_path("bryght", q: nil, kind: nil)
  end

  test "adding a duplicate silently redirects without creating a record" do
    assert_no_difference "Selection.count" do
      post selections_path("bryght"), params: { content_id: contents(:intro_ruby).id }
    end
    assert_redirected_to manage_path("bryght", q: nil, kind: nil)
  end

  test "removing a selection destroys it and redirects" do
    selection = selections(:bryght_ruby)
    assert_difference "Selection.count", -1 do
      delete selection_path("bryght", selection.id)
    end
    assert_redirected_to manage_path("bryght", q: nil, kind: nil)
  end

  test "preserves search params through redirect" do
    post selections_path("bryght"), params: { content_id: contents(:jazz_playlist).id, q: "jazz", kind: "playlist" }
    assert_redirected_to manage_path("bryght", q: "jazz", kind: "playlist")
  end
end
