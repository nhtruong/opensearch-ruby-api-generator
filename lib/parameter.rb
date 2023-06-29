# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

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

  def ruby_type
    type.capitalize
  end

  def example_value(standalone: true)
    case type
    when 'string'
      standalone ? ':foo' : 'foo'
    when 'integer'
      1
    when 'boolean'
      true
    when 'array'
      standalone ? "'foo,bar'" : "foo,bar"
    when 'time'
      "'1m'"
    else
      raise "Unknown type #{type}"
    end
  end
end
