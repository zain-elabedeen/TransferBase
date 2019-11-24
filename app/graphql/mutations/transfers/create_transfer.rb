module Mutations
  module Transfers
    class CreateTransfer < BaseMutation
      argument :receiver_account_id, ID, required: true
      argument :target_currency, String, required: true
      argument :amount, Float, required: true
  
      type Types::TransferType
  
      def resolve(receiver_account_id: nil, amount: nil, target_currency: nil)
        authenticate!

        sender_account_id = context[:current_user].account.id

        TransferService::CreateTransfer.call({
          sender_account_id: sender_account_id,
          receiver_account_id: receiver_account_id, 
          source_currency: Account::NATIVE_CURRENCY,
          target_currency: target_currency,
          amount: amount, 
        });
      end
    end
  end
end