module Types
  class QueryType < Types::BaseObject
    field :list_users, [Types::UserType], null: true
    # TODO: paginate and move to user query module/class
    def list_users
      return nil if !context[:current_user]

      User.all
    end
  end
end
