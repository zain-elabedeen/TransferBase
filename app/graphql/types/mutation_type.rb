module Types
  class MutationType < Types::BaseObject
    implements ::Types::GraphqlAuth
    field :create_user, mutation: Mutations::CreateUser
  end
end
