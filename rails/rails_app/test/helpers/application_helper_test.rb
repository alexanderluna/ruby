require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Rails App"
    assert_equal full_title("Help"), "Help | Rails App"
  end
end