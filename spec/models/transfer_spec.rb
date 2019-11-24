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


require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it "has a valid factory" do
    expect(build(:transfer)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
  end
end
