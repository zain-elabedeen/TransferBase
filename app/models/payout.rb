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


class Payout < ApplicationRecord
  belongs_to :account
  belongs_to :transfer

  validates :account, :transfer, :amount, :currency, presence: true
  validates :currency, inclusion: { in: Account::ACCEPTED_CURRENCIES }

  enum status: { error: 0, success: 1, processing: 2 }

  # Filter by currency
  scope :currency, -> (currency_sym) { where(currency: currency_sym) }
  # error and success states to be listed in list_payouts to the user
  scope :completed, -> { where("status = ? or status = ?", statuses[:error], statuses[:success]) }
end
