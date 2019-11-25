require 'rails_helper'

describe Mutations::Transfers::CreateTransfer, type: :request do
  context 'When user is not sgin in' do
    let!(:receiver_account)  { create(:account) }
    
    let(:create_transfer_variables) {
      create_mutation_variables(
        :transfer, { receiver_account_id: receiver_account.id }
      )
    }

    it 'returns an error' do     
      post('/graphql', 
        params: {
          query: create_transfer_mutation,
          variables: create_transfer_variables.to_json
        }
      )

      response_body, errors = parse_graphql_response(response.body)

      data = response_body['createTransfer']

      expect(data).to equal(nil)
    end
  end

  context 'When user is sgin in' do
    let!(:sender_account)  { create(:account) }
    let!(:receiver_account)  { create(:account) }

    # Used to stub currency layer request
    let(:exchange_rates_body) {
      { "success" => true,
        "quotes" => { "USDEUR" => 0.907334 }
      }
    }

    before do
      stub_request(
        :get,
        "#{ENV['CURRENCY_LAYER_API_URL']}/live?access_key=#{ENV['CURRENCYLAYER_ACCESS_KEY']}&currencies=EUR&source=USD"
      ).to_return(:status => 200, :body => exchange_rates_body.to_json)

      post('/graphql', 
        params: {
          query: sign_in_mutation,
          variables: {
            email: sender_account.user.email,
            password:  sender_account.user.password,
          }.to_json
        }
      )

      response_body = JSON.parse(response.body)
      @user_token = response_body["data"]["signIn"]["token"]
    end

    context 'When sender dose not have enough balance' do
      let(:create_transfer_variables) { 
        create_mutation_variables(
          :transfer, { receiver_account_id: receiver_account.id }
        )
      }

      it 'creates new transfer with status error' do     
        post('/graphql', 
          params: {
            query: create_transfer_mutation,
            variables: create_transfer_variables.to_json
          },
          headers: { 'Authorization' => "#{@user_token}" }
        )

        response_body = parse_graphql_response(response.body)

        data = response_body['createTransfer']

        expect(data).to include(
          'id'                  => be_present,
          'status'              => 'error',
          'amount'              => '1000.0',
          'senderAccountId'     => sender_account.id,
          'receiverAccountId'   => receiver_account.id
        )
      end
    end

    context 'When sender have enough balance' do
      let(:create_transfer_variables) { 
        create_mutation_variables(
          :transfer, { receiver_account_id: receiver_account.id }
        )
      }

      before do
        # Create a dummy transfer to the sender account to fill the account with some money
        transfer = create(:transfer, sender_account: sender_account, receiver_account: sender_account, status: 'success')
        payout = create(:payout, account: sender_account, transfer: transfer, status: 'success')
      end

      it 'creates new transfer with status success' do
        post('/graphql', 
          params: {
            query: create_transfer_mutation,
            variables: create_transfer_variables.to_json
          },
          headers: { 'Authorization' => "#{@user_token}" }
        )

        response_body = parse_graphql_response(response.body)

        data = response_body['createTransfer']

        expect(data).to include(
          'id'                  => be_present,
          'status'              => 'success',
          'amount'              => '1000.0',
          'senderAccountId'     => sender_account.id,
          'receiverAccountId'   => receiver_account.id
        )
      end
    end
  end
end