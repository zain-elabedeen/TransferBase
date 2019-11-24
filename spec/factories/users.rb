# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  password_digest :string           default(""), not null
#  name            :string           default("")
#









FactoryBot.define do
  factory :user do
    email   { Faker::Internet.unique.email }
    name    { Faker::Internet.unique.user_name }
    password  { Faker::Internet.password(10) }
  end
end
