module Types
  class QueryType < Types::BaseObject
    field :current_user, Types::UserType, null: true
    # TODO: Move to user query module/class
    def current_user
      context[:current_user]
    end

    field :list_users, [Types::UserType], null: true
    # TODO: paginate and move to user query module/class
    def list_users
      return nil if !context[:current_user]

      User.all
    end
  end
end
