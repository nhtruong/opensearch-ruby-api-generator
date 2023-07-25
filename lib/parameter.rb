# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require 'openapi3_parser/node/parameter'
require_relative 'version'

# Wrapper for Openapi3Parser::Node::Parameter that adds extra info
class Parameter < Openapi3Parser::Node::Parameter
  attr_reader :spec

  # @param [Openapi3Parser::Node::Parameter] spec Parameter Spec
  def initialize(spec)
    super(spec.node_data, spec.node_context)
    @spec = spec
  end


  def type
    schema['x-data-type'] || schema&.type
  end

  def ruby_type
    type.capitalize
  end

  def array?
    type == 'array'
  end

  def default
    schema&.default
  end

  def deprecated?
    return false unless schema.present?
    schema.deprecated?
  end

  def example_value
    return 'songs' if type == 'string'
    return 42 if type == 'integer'
    return true if type == 'boolean'
    return %w[books movies] if type == 'array'
    return '1m' if type == 'time'
    raise "Unknown type #{type}"
  end

  def expected_path_value
    type == 'array' ? example_value.join(',') : example_value
  end

  def client_double_value
    return "'#{example_value}'" if type.in?(%w[string time])
    return "%w[#{example_value.join(' ')}]" if type == 'array'
    example_value
  end

  def expected_query_value
    return "'#{example_value}'" if type.in?(%w[string time])
    return "'#{example_value.join(',')}'" if type == 'array'
    example_value
  end
end
