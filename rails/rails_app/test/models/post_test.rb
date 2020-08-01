require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:jim)
    @post = @user.posts.build(content: "lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = nil
    assert_not @post.valid?
  end

  test "content shouldn't be longer that 150 charactets" do
    @post.content = "a"*151
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
