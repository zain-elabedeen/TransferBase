# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  password_digest :string           default(""), not null
#  name            :string           default("")
#






require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user, password: Faker::Internet.password(10))).to be_valid
  end
end
