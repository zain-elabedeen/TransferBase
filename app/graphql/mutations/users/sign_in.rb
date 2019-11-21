module Mutations
  module Users
    class SignIn < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
  
      type Types::UserType
      
      def resolve(email: nil, password: nil)
        user = User.find_for_authentication(email: email)
        
        return nil if !user
        
        is_valid_for_auth = user.valid_for_authentication?{
          user.valid_password?(password)
        }

        return is_valid_for_auth ? user : nil
      end
    end
  end
end