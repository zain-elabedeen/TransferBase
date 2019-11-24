module Mutations
  module Users
    class SignIn < BaseMutation
      null true
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :token, String, null: true
      
      def resolve(email: nil, password: nil)
        user = User.find_by(email: email) 

        return unless user
        return unless user.authenticate(password)
        # Generate and sign user token using MessageEncryptor
        # TODO: Use JWT tokens
        crypt = ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'].byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")

        { user: user, token: token }
      end
    end
  end
end