class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers, id: :uuid do |t|
      t.decimal :amount, null: false
      t.decimal :exchange_rate
      t.string  :target_currency
      t.string  :source_currency
      t.integer :status, default: 2
     
      t.references :sender_account, foreign_key: { to_table: 'accounts'}, type: :uuid, null: false
      t.references :receiver_account, foreign_key: { to_table: 'accounts'}, type: :uuid, null: false

      t.timestamps null: false
    end
  end
end
