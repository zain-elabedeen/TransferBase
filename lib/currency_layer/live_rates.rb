module CurrencyLayer
  class LiveRates
    def self.get_rate(source_currency, target_currencies)
      throw ArgumentError.new('Required arguments :source_currency missing') if source_currency.nil?
      throw ArgumentError.new('Required arguments :target_currencies missing') if target_currencies.nil?
      
      exchange_rates = CurrencyLayer::Api.new.get({source: source_currency, currencies: target_currencies})

      # TODO: parse using key-value
      exchange_rates.values.first
    end
  end
end

