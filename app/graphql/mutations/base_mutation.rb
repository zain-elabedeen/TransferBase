module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def authenticate!
      return if context[:current_user]

      raise GraphQL::ExecutionError,
            "You are not logged in, please login to continue "
    end
  end
end