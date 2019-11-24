# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  password_digest :string           default(""), not null
#  name            :string           default("")
#








class User < ApplicationRecord
  has_secure_password

  has_one :account, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
