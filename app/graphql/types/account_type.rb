module Types
  class AccountType < BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: true
  end
end