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

      initialize_user_account(account)

      user
    end

    private

    def initialize_user_account(account)
      # Create initial 1000 USD transfer from the GOLDEN USER account

      golden_user = User.find_by(email: ENV['GOLD_EMAIL'])

      return if !golden_user

      TransferService::CreateTransfer.call({
        sender_account_id: golden_user.account.id,
        receiver_account_id: account.id,
        source_currency: Account::NATIVE_CURRENCY,
        target_currency: Account::NATIVE_CURRENCY,
        amount: 1000,
      })
    end
  end
end