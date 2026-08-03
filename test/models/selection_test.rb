require "test_helper"

class SelectionTest < ActiveSupport::TestCase
  test "valid selection" do
    assert selections(:bryght_ruby).valid?
  end

  test "duplicate community+content pair is invalid" do
    dupe = Selection.new(
      community: communities(:bryght),
      content: contents(:intro_ruby)
    )
    assert_not dupe.valid?
    assert_includes dupe.errors[:content_id], "has already been taken"
  end

  test "same content can be selected by different communities" do
    selection = Selection.new(
      community: communities(:other),
      content: contents(:intro_ruby)
    )
    assert selection.valid?
  end
end
