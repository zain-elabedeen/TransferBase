module Types
    class UserType < BaseObject
      field :id, ID, null: false
      field :jti, String, null: false
      field :full_name, String, null: false
    end
  end