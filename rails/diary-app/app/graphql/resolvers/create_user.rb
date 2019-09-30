class Resolvers::CreateUser < GraphQL::Function
  # arguments passed as "args"
  argument :name, !types.String
  argument :email, !types.String
  argument :password, !types.String
  argument :password_confirmation, !types.String

  # return type from the mutation
  type Types::UserType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    User.create!(
      name: args[:name],
      email: args[:email],
      password: args[:password],
      password_confirmation: args[:password_confirmation]
    )
  end
end
