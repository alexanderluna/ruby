require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select "nav a", minimum: 4
    assert_select "main ul li", 3
    assert_select "h2", "Lager Beer"
    # \$ matches literal $ sign
    # [,\d]+ matches more than one digit or comma ex. 1,000
    # \. matches a literal period
    # \d\d matches 2 digits ex. 1.20
    assert_select "div", /\$[,\d]+\.\d\d/
  end
end
