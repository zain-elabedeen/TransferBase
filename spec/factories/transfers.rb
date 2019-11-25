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


FactoryBot.define do
  factory :transfer do
    source_currency { 'USD' }
    target_currency { 'EUR' }
    amount          { '1000' }
    exchange_rate   { 0.75 }
    
    association :sender_account, factory: :account
    association :receiver_account, factory: :account
  end
end
