class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      
      t.timestamps null: false
    end
  end
end
