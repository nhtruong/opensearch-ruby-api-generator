# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

require 'openapi3_parser'
require_relative 'base'
require_relative 'method_documentation'
require_relative 'method_arguments'

module Opensearch
  module ApiGenerator
    # Logic To Generate an API Method
    class Action < Base
      include MethodDocumentation
      include MethodArguments

      self.template_file = './templates/action.mustache'

      attr_reader :operations

      # @param [Array<Openapi3Parser::Node::Operation>] operations
      def initialize(operations)
        super
        @operations = operations
      end

      def namespace
        operations[0]['x-namespace'].camelize
      end

      def method_name
        operations[0]['x-action'].underscore
      end

      def path
        '#{_index}/docs/#{_id}'
      end

      def http_verb
        'PUT'
      end
    end
  end
end
