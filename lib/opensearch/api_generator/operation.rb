# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

require 'openapi3_parser/node/operation'

module Opensearch
  module ApiGenerator
    # Wrapper for Openapi3Parser::Node::Operation that adds extra info
    class Operation < Openapi3Parser::Node::Operation
      attr_reader :path, :http_verb, :namespace, :action

      # @param [Openapi3Parser::Node::Operation] operation
      # @param [String] path
      # @param [String] http_verb
      def initialize(operation, path, http_verb)
        super(operation.node_data, operation.node_context)
        @path = path
        @http_verb = http_verb
        @namespace = operation['x-namespace']
        @action = operation['x-action']
      end
    end
  end
end
