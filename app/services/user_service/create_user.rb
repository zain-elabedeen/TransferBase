module UserService
  class CreateUser < ApplicationService
    def initialize(user_params)
      throw ArgumentError.new('Required arguments :email missing') if user_params[:email].nil?
      throw ArgumentError.new('Required arguments :password missing') if user_params[:password].nil?
      throw ArgumentError.new('Required arguments :name missing') if user_params[:name].nil?

      @user_params = user_params
    end

    def call
      user, account = nil

      User.transaction do
        user =  User.create!(@user_params)

        account = Account.create!(user: user)
      end

      user
    end
  end
end