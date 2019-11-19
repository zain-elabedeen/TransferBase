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



FactoryBot.define do
  factory :account do
    
  end
end
