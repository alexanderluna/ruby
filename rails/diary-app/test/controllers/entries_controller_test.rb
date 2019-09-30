require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @entry = entries(:one)
    @other_entry = entries(:two)
    @user  = users(:alexander)
  end

  # not logged in
  test "redirect Index when not logged in" do
    get entries_path
    assert_response :redirect
  end

  test "redirect Show when not logged in" do
    get entry_path(@entry)
    assert_response :redirect
  end

  test "redirect New when not logged in" do
    get new_entry_path
    assert_response :redirect
  end

  test "redirect Edit when not logged in" do
    get edit_entry_path(@entry)
    assert_response :redirect
  end


  # logged in
  test "GET Index when logged in" do
    sign_in @user
    get entries_path
    assert_response :success
  end

  test "GET Show when logged in" do
    sign_in @user
    get entry_path(@entry)
    assert_response :success
  end

  test "GET New when logged in" do
    sign_in @user
    get new_entry_path
    assert_response :success
  end

  test "GET Edit when logged in" do
    sign_in @user
    get edit_entry_path(@entry)
    assert_response :success
  end

  test "redirect when accessing other user's post" do
    sign_in @user
    get entry_path(@other_entry)
    assert_response :redirect
    get edit_entry_path(@other_entry)
    assert_response :redirect
  end
end
