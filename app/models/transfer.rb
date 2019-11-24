# == Schema Information
#
# Table name: transfers
#
#  id                  :uuid             not null, primary key
#  amount              :decimal(, )      not null
#  exchange_rate       :decimal(, )
#  target_currency     :string
#  source_currency     :string
#  status              :integer          default("processing")
#  sender_account_id   :uuid             not null
#  receiver_account_id :uuid             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_transfers_on_receiver_account_id  (receiver_account_id)
#  index_transfers_on_sender_account_id    (sender_account_id)
#



class Transfer < ApplicationRecord
    has_many :payouts, dependent: :destroy

    belongs_to :sender_account, foreign_key: 'sender_account_id', class_name: 'Account'
    belongs_to :receiver_account, foreign_key: 'receiver_account_id', class_name: 'Account'
    

    validates :target_currency, inclusion: { in: Account::ACCEPTED_CURRENCIES }
    validates :source_currency, acceptance: { accept: Account::NATIVE_CURRENCY }
    validates :amount, presence: true

    enum status: { error: 0, success: 1, processing: 2 }
end
