module UsersHelper
  def gravatar_for(user, options={size: '100', css: "gravatar" })
    image_tag(user.avatar, alt: user.name, size: options[:size], class: options[:css])
  end

  def short_name(user)
    user.name.split(' ')[0]
  end
end
