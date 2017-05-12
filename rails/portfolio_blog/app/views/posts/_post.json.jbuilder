json.extract! post, :id, :content, :git_link, :views, :created_at, :updated_at
json.url post_url(post, format: :json)
