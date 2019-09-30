require 'test_helper'

class StaticSiteControllerTest < ActionDispatch::IntegrationTest

  test "GET home route" do
    get root_path
    assert_response :success
    assert_select 'nav', count: 0
    assert_select 'a[href=?]', new_user_registration_path, count: 1
    assert_select 'a[href=?]', new_user_session_path, count: 1
  end
end
