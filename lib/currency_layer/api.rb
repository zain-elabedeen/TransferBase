require 'faraday'
require 'faraday_middleware'

module CurrencyLayer
  class Api
    END_POINT = 'live'
    BASE_URL = ENV['CURRENCY_LAYER_API_URL']
    ACCESS_KEY = ENV['CURRENCYLAYER_ACCESS_KEY']

    def get(options)
      options.merge!(access_key: ACCESS_KEY)
      
      response = connection.get END_POINT, options
  
      parse_response(response)
    end
    
    private

    def connection
      Faraday.new(url: BASE_URL) do |connection|
        connection.headers['Content-Type'] = 'application/json'
        connection.use ::FaradayMiddleware::ParseJson
        connection.adapter Faraday.default_adapter
      end
    end

    def parse_response(response)
      response.status == 200 ? success(response) : errors(response)
    end

    def success(response)
      body = response.body

      body['quotes']
    end

    def errors(response)
      error = {
        errors: { 
          status: response['status'], 
          message: response['message'] 
          } 
        }

      response.merge(error)
    end
  end
end