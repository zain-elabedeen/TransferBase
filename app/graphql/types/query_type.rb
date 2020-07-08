module Types
  class QueryType < Types::BaseObject
    field :current_user, Types::UserType, null: true
    
    def current_user
      context[:current_user]
    end

    field :list_users, [Types::UserType], null: true

    def list_users
      return nil if !context[:current_user]

      User.all
    end

    field :list_payouts, [Types::PayoutType], null: true

    def list_payouts
      return nil if !context[:current_user]

      context[:current_user].account.payouts.completed
    end
  end
end
