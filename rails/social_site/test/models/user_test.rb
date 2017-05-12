require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:alex)
  end

  test "should be valid" do
    @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email shoud be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should be not too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be valid" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr.inspect} should be valid"
    end
  end

  test "email should be invalid" do
    invalid_address = %w[user@gmail,com Userfoo.com foo@bar_bar.]
    invalid_address.each do |iaddr|
      @user.email = iaddr
      assert_not @user.valid?, "#{iaddr.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    dubble_address = @user.dup
    dubble_address.email = @user.email.upcase
    @user.save
    assert_not dubble_address.valid?
  end
end
