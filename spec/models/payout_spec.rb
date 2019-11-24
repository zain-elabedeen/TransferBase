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


require 'rails_helper'

RSpec.describe Payout, type: :model do
  it "has a valid factory" do
    expect(build(:payout)).to be_valid
  end
    
  context 'validations' do
    it { is_expected.to validate_presence_of(:transfer) }
    it { is_expected.to validate_presence_of(:account) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:currency) }
  end

  describe 'scopes' do
    context '#completed' do
      it 'returns success and error payouts' do
        create(:payout, status: 'error')
        create(:payout, status: 'processing')
        create(:payout, status: 'success')
        
        payouts = Payout.completed
        payout_statuses = payouts.map{ |payout| payout.status }

        expect(payout_statuses).to include('success', 'error')
      end
    end
  end
end
