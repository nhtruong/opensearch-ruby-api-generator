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

      # @param [String] path
      # @param [String] http_verb
      # @param [Array<Openapi3Parser::Node::Operation>] operations
      def initialize(path, http_verb, operations)
        @path = path
        @http_verb = http_verb
        @operations = operations
        super()
      end

      def namespace
        @operations[0]['x-namespace']&.camelize
      end

      def method_name
        @operations[0]['x-action'].underscore
      end

      def path
        @path.split('/').select(&:present?).map do |component|
          if component.starts_with? '{'
            "_#{component[/{(.+)}/, 1]}"
          else
            "'#{component}'"
          end
        end.join(', ')
      end

      def http_verb
        if @http_verb == 'get-post'
          'body ? OpenSearch::API::HTTP_POST : OpenSearch::API::HTTP_GET'
        else
          "OpenSearch::API::HTTP_#{@http_verb.upcase}"
        end
      end
    end
  end
end
