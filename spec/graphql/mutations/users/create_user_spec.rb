require 'rails_helper'

describe Mutations::Users::CreateUser, type: :request do
  context 'When user is valid' do
  let(:user) { user(:build) }
  let(:create_user_variables) { create_mutation_variables(:user, { password: Faker::Internet.password(10) }) }


    it 'creates new user' do
      post('/graphql', params: {
        query: create_user_mutation,
        variables: create_user_variables.to_json
      })

      response_body = parse_graphql_response(response.body)

      data = response_body['createUser']

      expect(data).to include(
        'id'     => be_present,
        'name'   => create_user_variables["name"]
      )
    end
  end

  context 'When user exists' do
    let(:old_user) { create(:user) }
    let(:create_user_variables) { create_mutation_variables(:user, { email: old_user.email }) }

    it 'raise an error' do
      expect { 
        post('/graphql', params: {
          query: create_user_mutation,
          variables: create_user_variables.to_json
        })
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end