module Types
  class PayoutType < Types::BaseObject
    field :id, ID, null: false
    field :account_id, ID, null: true
    field :amount, Float, null: false
    field :currency, String, null: true
    field :status, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
    field :transfer, Types::TransferType, null: true
    field :account, Types::AccountType, null: false
  end
end