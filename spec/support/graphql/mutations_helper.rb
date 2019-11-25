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

    def create_transfer_mutation
      %(
        mutation createTrasnfer(
          $receiverAccountId: ID!,
          $targetCurrency: String!, 
          $amount: String!
        ) {
          createTransfer(
            receiverAccountId: $receiverAccountId,
            targetCurrency: $targetCurrency,
            amount: $amount
          ) {
              id
              senderAccountId
              receiverAccountId
              amount,
              status
            }
        }        
      )
    end

    def sign_in_mutation
      %(
        mutation signIn(
          $email: String!,
          $password: String!,
        ) {
          signIn(
            email: $email,
            password: $password,
          ) {
              user {
                id
                name
              }
              token
            }
        }        
      )
    end
  end
end