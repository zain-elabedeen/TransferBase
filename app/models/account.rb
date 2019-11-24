# == Schema Information
#
# Table name: accounts
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#







class Account < ApplicationRecord
  has_many :payouts
  has_many :sent_transfers, foreign_key: 'sender_account_id', class_name: "Transfer"
  has_many :received_transfers, foreign_key: 'receiver_account_id', class_name: "Transfer"
    
  belongs_to :user

  validates :user, presence: true

  NATIVE_CURRENCY = 'USD'
  ACCEPTED_CURRENCIES = %w(USD GBP EUR)
end
