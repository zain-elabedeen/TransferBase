 module Types
  class TransferType < Types::BaseObject
    field :id, ID, null: false
    field :sender_account_id, ID, null: true
    field :receiver_account_id, ID, null: true
    field :amount, String, null: false
    field :target_currency, String, null: true
    field :status, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
    field :sender_account, Types::AccountType, null: true
    field :receiver_account, Types::AccountType, null: true
  end
end