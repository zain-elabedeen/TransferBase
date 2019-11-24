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






require 'rails_helper'

RSpec.describe Account, type: :model do
  it "has a valid factory" do
    expect(build(:account)).to be_valid
  end

  let(:account) { build(:account) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
  end

  describe "instance methods" do
    context "responds to" do
      it { expect(account).to respond_to(:balance) }
    end

    context "#balance" do
      let!(:receiver_account)  { create(:account) }

      let!(:payout_1) { create(:payout, account: receiver_account, amount: 1000, status: 'success') }
      let!(:payout_2) { create(:payout, account: receiver_account, amount: - 500, status: 'success') }
      let!(:payout_3) { create(:payout, account: receiver_account, amount: - 100, currency: 'EUR', status: 'processing') }
      let!(:payout_4) { create(:payout, account: receiver_account, amount: 1000, currency: 'EUR', status: 'success') }
      let!(:payout_5) { create(:payout, account: receiver_account, amount: - 70, currency: 'EUR', status: 'success') }
      let!(:payout_6) { create(:payout, account: receiver_account, amount: - 200, currency: 'EUR', status: 'error') }
      
      it "calcualte account balance correctly" do
        expect(receiver_account.balance('USD')).to eq(BigDecimal("500"))
        expect(receiver_account.balance('EUR')).to eq(BigDecimal("930"))
        expect(receiver_account.balance('GBP')).to eq(BigDecimal("0"))
      end
    end
  end
end
