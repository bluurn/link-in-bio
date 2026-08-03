require "test_helper"

class CommunityTest < ActiveSupport::TestCase
  test "valid with name and slug" do
    assert communities(:bryght).valid?
  end

  test "requires name" do
    assert_not Community.new(slug: "test").valid?
  end

  test "requires slug" do
    assert_not Community.new(name: "Test").valid?
  end

  test "slug must be unique" do
    dupe = Community.new(name: "Dupe", slug: "bryght")
    assert_not dupe.valid?
    assert_includes dupe.errors[:slug], "has already been taken"
  end

  test "slug rejects uppercase and spaces" do
    assert_not Community.new(name: "X", slug: "My Slug").valid?
    assert_not Community.new(name: "X", slug: "MySlug").valid?
  end

  test "slug allows lowercase, numbers, hyphens" do
    assert Community.new(name: "X", slug: "my-slug-123").valid?
  end

  test "to_param returns slug" do
    assert_equal "bryght", communities(:bryght).to_param
  end

  test "destroying community cascades to selections" do
    community = communities(:bryght)
    assert_difference "Selection.count", -community.selections.count do
      community.destroy
    end
  end
end
