class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest, null: false, default: ""
      t.string :name,  default: ""
    end
  end
end
