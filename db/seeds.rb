gold = User.create(email: ENV['GOLD_EMAIL'], name: 'Gold Bank', password: '12345!Aa')
money_machine = Account.create(user: gold)

transfer = Transfer.create!(
  sender_account_id: money_machine.id,
  receiver_account_id: money_machine.id,
  source_currency: 'USD',
  target_currency: 'USD',
  exchange_rate: '0',
  amount: 10000000000,
  status: 'success'
)

Payout.create!(
  transfer_id: transfer.id,
  account_id: transfer.sender_account_id,
  amount: transfer.amount,
  currency: transfer.source_currency,
  status: 'success'
)

user1 = User.create(email: 'user1@test.com',name: 'User 1', password: '12345!Aa')
Account.create(user: user1)

user2 = User.create(email: 'user2@test.com',name: 'User 2', password: '12345!Aa')
Account.create(user: user2)
