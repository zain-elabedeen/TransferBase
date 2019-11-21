module GraphQL
  module ParseResponse
    def parse_graphql_response(response)
      JSON.parse(response).delete('data')
    end
  end
end