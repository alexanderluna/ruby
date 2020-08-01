require "test_helper"

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jim)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    assert_select "div.pagination"
    assert_select "input[type=file]"

    assert_no_difference "Post.count" do
      post posts_path, params: { post: { content: " " } }
    end

    assert_select "div#error_explanation"
    assert_select "a[href=?]", "/?page=2"

    content = "my new post"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    assert_difference "Post.count", 1 do
      post posts_path, params: { post: { content: content, image: image } }
    end
    assert @user.posts.first.image.attached?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body

    assert_select "a", text: "delete"
    first_post = @user.posts.paginate(page: 1).first
    assert_difference "Post.count", -1 do
      delete post_path(first_post)
    end
    get user_path(users(:alexander))
    assert_select 'a', text: "delete", count: 0
  end

  test "post sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.posts.count} posts", response.body

    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 posts", response.body
    other_user.posts.create!(content: "A post")
    get root_path
    assert_match "1 post", response.body
  end
end
