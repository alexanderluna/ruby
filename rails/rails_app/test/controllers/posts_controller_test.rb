require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @post = posts(:most_recent)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Post.count" do
      post posts_path, params: { post: { content: "lorem ipsum" }}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(users(:jim))
    post = posts(:ants)
    assert_no_difference "Post.count" do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

end
