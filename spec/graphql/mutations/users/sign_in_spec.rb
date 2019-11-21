require 'rails_helper'

describe Mutations::Users::SignIn do
  let(:user) { create(:user) }

  def perform(args = {})
    Mutations::Users::SignIn.new(object: nil, context: {}).resolve(args)
  end

  describe 'When user credentials are valid' do
    it 'sign-in and return the user successfully' do
      result = perform(
        email: user.email, 
        password: user.password
      )

      expect(result.email).to eq(user.email)
    end
  end

  describe 'When user credentials are invalid' do
    it 'wrong email returns nil' do
      result = perform(
        email: Faker::Internet.unique.email, 
        password: user.password
      )

      expect(result).to eq(nil)
    end

    it 'wrong password returns nil' do
      result = perform(
        email: user.email, 
        password: Faker::Internet.password(8)
      )

      expect(result).to eq(nil)
    end
  end
end