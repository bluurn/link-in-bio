require "test_helper"

class ContentTest < ActiveSupport::TestCase
  test "valid content" do
    assert contents(:intro_ruby).valid?
  end

  test "requires title" do
    c = contents(:intro_ruby).dup
    c.title = ""
    assert_not c.valid?
  end

  test "requires creator" do
    c = contents(:intro_ruby).dup
    c.creator = ""
    assert_not c.valid?
  end

  test "requires url" do
    c = contents(:intro_ruby).dup
    c.url = ""
    assert_not c.valid?
  end

  test "price must be non-negative" do
    c = contents(:intro_ruby).dup
    c.title = "Unique Title #{rand}"
    c.price = -1
    assert_not c.valid?
  end

  test "kind enum includes course event playlist" do
    assert Content.kinds.key?("course")
    assert Content.kinds.key?("event")
    assert Content.kinds.key?("playlist")
  end

  test "search scope filters by title case-insensitively" do
    results = Content.search("introduction to ruby")
    assert_includes results, contents(:intro_ruby)
    assert_not_includes results, contents(:rails_summit)
  end

  test "search scope returns all when blank" do
    assert_equal Content.count, Content.search("").count
    assert_equal Content.count, Content.search(nil).count
  end

  test "by_kind scope filters correctly" do
    results = Content.by_kind("course")
    assert_includes results, contents(:intro_ruby)
    assert_not_includes results, contents(:rails_summit)
  end

  test "by_kind scope returns all when blank" do
    assert_equal Content.count, Content.by_kind("").count
    assert_equal Content.count, Content.by_kind(nil).count
  end
end
