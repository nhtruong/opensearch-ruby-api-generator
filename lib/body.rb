# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require 'openapi3_parser/node/parameter'
require_relative 'version'

# Request Body is a special type of Parameter
class Body < Openapi3Parser::Node::RequestBody
  attr_reader :spec, :type, :javascript_type, :is_array, :default, :deprecated,
              :camel_name, :snake_name, :many_names, :description, :name

  # @param [Openapi3Parser::Node::RequestBody] spec RequestBody Spec
  def initialize(spec)
    super(spec.node_data, spec.node_context)
    @spec = spec
    @name = 'body'
    @description = content&.[]('application/json')&.schema&.description
    @type = @javascript_type = 'Object'
    @camel_name = 'body'
    @snake_name = 'body'
    @names = ['body'].uniq
    @many_names = @names.size > 1
  end

  def deprecated?
    false
  end
end
