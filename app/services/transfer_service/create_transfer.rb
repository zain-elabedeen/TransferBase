module TransferService
  class CreateTransfer < ApplicationService
    def initialize(tranfser_params)
      throw ArgumentError.new('Required arguments :receiver_account_id missing') if tranfser_params[:receiver_account_id].nil?
      throw ArgumentError.new('Required arguments :sender_account_id missing') if tranfser_params[:sender_account_id].nil?
      throw ArgumentError.new('Required arguments :target_currency missing') if tranfser_params[:target_currency].nil?
      throw ArgumentError.new('Required arguments :source_currency missing') if tranfser_params[:source_currency].nil?
      throw ArgumentError.new('Required arguments :amount missing') if tranfser_params[:amount].nil?

      @transfer_params = tranfser_params


      # TODO: get exchange rates using a live API
      @exchange_rate = 0.5
    end

    def call
      @transfer = create_transfer

      if (sender_account_balance >= @transfer.amount) then
        process_successful_transfer
      else
        process_faild_transfer
      end

      @transfer
    end

    private

    def create_transfer
      Transfer.create!(
        sender_account_id:   @transfer_params[:sender_account_id],
        receiver_account_id: @transfer_params[:receiver_account_id],
        source_currency:     @transfer_params[:source_currency],
        target_currency:     @transfer_params[:target_currency],
        exchange_rate:       @exchange_rate,
        amount:              @transfer_params[:amount],
        status:              'processing' 
      )
    end

    def process_successful_transfer
      # Create success payouts
      Payout.transaction do
        # Sender payout
        Payout.create!(
          transfer_id: @transfer.id,
          account_id:  @transfer.sender_account_id,
          amount:      - @transfer.amount,
          currency:    @transfer.source_currency,
          status:      'success'
        )

        # Receiver payout
        amount_exchanged = @transfer.amount * @transfer.exchange_rate

        Payout.create!(
          transfer_id: @transfer.id,
          account_id:  @transfer.receiver_account_id,
          amount:      amount_exchanged,
          currency:    @transfer.target_currency,
          status:      'success'
        )
        # Set the transaction status to success 
        @transfer.success!
      end
    end

    def process_faild_transfer
      # Create faild payout at the receiver side
      amount_exchanged = @transfer.amount * @transfer.exchange_rate

      Payout.transaction do
        Payout.create!(
          transfer_id: @transfer.id,
          account_id:  @transfer.receiver_account_id,
          amount:      amount_exchanged,
          currency:    @transfer.target_currency,
          status:      'error'
        )
        # Set the transaction status to error
        @transfer.error!
      end
    end

    def sender_account_balance
      sender_account = Account.find(@transfer.sender_account_id)
      
      sender_account.balance(@transfer.source_currency)
    end
  end
end