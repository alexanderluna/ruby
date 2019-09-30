require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:alexander)
  end

  test "should save valid user" do
    @user.valid?
  end

  test "should check email presence" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "should check name presense" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email address should be unique" do
    dubble_address = @user.dup
    dubble_address.email = @user.email.upcase
    @user.save
    assert_not dubble_address.valid?
  end

end
