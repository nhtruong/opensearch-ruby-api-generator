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
require_relative '../base_generator'
require_relative '../operation'
require_relative 'method_documentation'
require_relative 'method_arguments'

module Api
  module Action
    # Logic To Generate an API Action via Mustache
    class Generator < BaseGenerator
      include MethodDocumentation
      include MethodArguments

      self.template_file = './templates/action.mustache'

      attr_reader :namespace, :action

      # @param [Array<Api::Operation>] operations
      def initialize(operations)
        @operations = operations
        @namespace = @operations.first.namespace
        @action = @operations.first.action
        @http_verbs = operations.map(&:http_verb).sort
        @urls = Set.new(operations.map(&:url))
        validate
        super
      end

      def module_name
        namespace&.camelize
      end

      def method_name
        action.underscore
      end

      def url_components
        @urls.max_by(&:length).split('/').select(&:present?).map do |component|
          if component.starts_with? '{'
            "_#{component[/{(.+)}/, 1]}"
          else
            "'#{component}'"
          end
        end.join(', ')
      end

      def http_verb
        case @http_verbs
        when %w[get post]
          'body ? OpenSearch::API::HTTP_POST : OpenSearch::API::HTTP_GET'
        when %w[post put]
          "_#{verb_diff.first[/{(.+)}/, 1]} ? OpenSearch::API::HTTP_PUT : OpenSearch::API::HTTP_POST"
        else
          "OpenSearch::API::HTTP_#{@http_verbs.first.upcase}"
        end
      end

      private

      def validate
        return if @operations.length == 1
        raise 'Can only combine upto 2 operations into 1 action' if @operations.length > 2

        case @http_verbs
        when %w[get post]
          raise 'Can only combine get/post operations if they share the same path' if @paths.size > 1
        when %w[post put]
          raise 'Can only combine put/post operations if their paths differ by 1 argument' if verb_diff.size != 1
        else
          raise "Cannot combine #{@http_verbs.join('/')} operations"
        end
      end

      def verb_diff
        @paths.map { |path| Set.new(path.split('/')) }.sort_by(&:size).reverse.reduce(&:difference)
      end
    end
  end
end
