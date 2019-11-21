module Mutations
  module Users
    class CreateUser < BaseMutation
      argument :email, String, required: true
      argument :full_name, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
  
      type Types::UserType
  
      def resolve(email: nil, password: nil, password_confirmation: nil, full_name: nil)
        User.transaction do
          user =  User.create!(
            email: email, 
            password: password, 
            password_confirmation: password_confirmation,
            full_name: full_name,
          )

          Account.create!(user: user) if user

          user
        end
      end
    end
  end
end