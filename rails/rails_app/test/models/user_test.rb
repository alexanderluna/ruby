require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      name: "alejandro",
      email: "alejandro@email.com",
      password: "alejandro",
      password_confirmation: "alejandro"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 255 + "@email.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "email validation should reject invalid emails" do
    valid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    valid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user =  @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be at least 6 characters long" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, ' ')
  end

  test "asociated post should be destroyed" do
    @user.save
    @user.posts.create!(content: "hello world")
    assert_difference "Post.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow user" do
    jim = users(:jim)
    alexander = users(:alexander)
    assert_not jim.following?(alexander)
    jim.follow(alexander)
    assert jim.following?(alexander)
    assert alexander.followers.include?(jim)
    jim.unfollow(alexander)
    assert_not jim.following?(alexander)
  end

  test "feed should have the right posts" do
    alexander = users(:alexander)
    jim = users(:jim)
    malory = users(:malory)

    malory.posts.each do |post_following|
      assert jim.feed.include?(post_following)
    end

    jim.posts.each do |post_self|
      assert jim.feed.include?(post_self)
    end

    malory.posts.each do |post_unfollowed|
      assert_not alexander.feed.include?(post_unfollowed)
    end
  end

end
