# == Schema Information
#
# Table name: payouts
#
#  id          :uuid             not null, primary key
#  amount      :decimal(, )      not null
#  currency    :string
#  status      :integer          default("processing")
#  account_id  :uuid
#  transfer_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payouts_on_account_id   (account_id)
#  index_payouts_on_transfer_id  (transfer_id)
#

FactoryBot.define do
  factory :payout do
    amount   { 10000 }
    currency { 'USD' }
    association :account
    association :transfer
  end
end
