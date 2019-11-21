module Mutations
  module Users
    class CreateUser < BaseMutation
      argument :email, String, required: true
      argument :name, String, required: true
      argument :password, String, required: true
  
      type Types::UserType
  
      def resolve(email: nil, password: nil, name: nil)
        UserService::CreateUser.call({
          email: email,
          password: password,
          name: name
        })
      end
    end
  end
end