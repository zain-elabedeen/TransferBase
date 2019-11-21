module GraphQL
  module MutationsHelper
    def create_user_mutation
      %(
        mutation createUser(
          $email: String!,
          $password: String!,
          $name: String!
        ) {
          createUser(
            email: $email,
            password: $password,
            name: $name
          ) {
            id
            name
          }
        }
      )
    end
  end
end