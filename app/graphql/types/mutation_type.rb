module Types
  class MutationType < Types::BaseObject
    # Users
    field :create_user, mutation: Mutations::Users::CreateUser
    field :sign_in, mutation: Mutations::Users::SignIn
  end
end
