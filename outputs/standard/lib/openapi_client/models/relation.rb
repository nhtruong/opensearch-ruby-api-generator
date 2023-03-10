=begin
#OpenSearch

#No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)

The version of the OpenAPI document: 2021-11-23

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.2.1

=end

require 'date'
require 'time'

module OpenapiClient
  class Relation
    EQ = "eq".freeze
    GTE = "gte".freeze

    def self.all_vars
      @all_vars ||= [EQ, GTE].freeze
    end

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def self.build_from_hash(value)
      new.build_from_hash(value)
    end

    # Builds the enum from string
    # @param [String] The enum value in the form of the string
    # @return [String] The enum value
    def build_from_hash(value)
      return value if Relation.all_vars.include?(value)
      raise "Invalid ENUM value #{value} for class #Relation"
    end
  end
end
