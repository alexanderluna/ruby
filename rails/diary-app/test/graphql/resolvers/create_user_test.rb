require 'test_helper'

class Resolvers::CreateUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateUser.new.call(nil, args, {})
  end

  test 'creating new User' do
    user = perform(
      name: 'Alex',
      email: 'alex@gmail.com',
      password: 'onetwothree',
      password_confirmation: 'onetwothree'
    )

    assert user.persisted?
    assert_equal user.name, 'Alex'
    assert_equal user.email, 'alex@gmail.com'
  end
end
