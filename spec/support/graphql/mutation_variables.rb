module GraphQL
  module MutationVariables
    def create_mutation_variables(resource, attrs = {})
      resource_attrs = attributes_for(resource)
      # Merge the arguments
      attrs.reverse_merge!(resource_attrs)

      # Camelize the attributes for graphql
      camelize_hash_keys(attrs)
    end

    def camelize_hash_keys(hash)
      raise unless hash.is_a?(Hash)

      hash.transform_keys { |key| key.to_s.camelize(:lower) }
    end
  end
end
