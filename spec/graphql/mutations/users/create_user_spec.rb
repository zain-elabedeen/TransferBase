require 'rails_helper'

describe Mutations::Users::CreateUser do
  let(:user) { build(:user) }

  def perform(args = {})
    Mutations::Users::CreateUser.new(object: nil, context: {}).resolve(args)
  end

  describe 'When user is valid' do
    it 'creates new user' do
      result = perform(
        email: user.email, 
        password: user.password,
        password_confirmation: user.password,
        full_name: user.full_name
      )

      expect(result.email).to eq(user.email)
      expect(result.full_name).to eq(user.full_name)  
    end
  end

  describe 'When user email exists' do
    let(:old_user) { create(:user) }

    it 'raise an error' do
      expect { 
        perform(
          email: old_user.email,
          password: user.password,
          password_confirmation: user.password,
          full_name: user.full_name
        )
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'When user password confirmation dose not match' do
    it 'returns an error' do
      expect {
        perform(
          email: user.email, 
          password: user.password,
          password_confirmation: Faker::Internet.password(10),
          full_name: user.full_name
        )
      }.to raise_error(ActiveRecord::RecordInvalid)

    end
  end

  describe 'When user full name dose not exist' do
    it 'returns an error' do
      expect {
         perform(
          email: user.email, 
          password: user.password,
          password_confirmation: user.password
        )
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end