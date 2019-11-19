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
  describe 'validations' do
    subject { build :account }

    it { is_expected.to validate_presence_of(:user) }
  end
end
