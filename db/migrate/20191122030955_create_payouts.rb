class CreatePayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :payouts, id: :uuid do |t|
      t.decimal  :amount, null: false
      t.string   :currency
      t.integer  :status, default: 2 

      t.references :account, foreign_key: true, type: :uuid
      t.references :transfer, foreign_key: true, type: :uuid
      
      t.timestamps null: false
    end
  end
end
