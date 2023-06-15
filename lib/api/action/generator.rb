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
      self.template_file = './templates/action.mustache'
      include MethodDocumentation
      include MethodArguments

      attr_reader :namespace, :action

      # @param [Array<Api::Operation>] operations
      def initialize(operations)
        @operations = operations
        @namespace = @operations.first&.namespace
        @action = @operations.first&.action
        @http_verbs = operations.map(&:http_verb)
        @urls = Set.new(operations.map(&:url))
        super
      end

      def module_name
        namespace&.camelize
      end

      def method_name
        action.underscore
      end

      def valid_params_constant_name
        "#{method_name.upcase}_QUERY_PARAMS"
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
        case @http_verbs.uniq.sort
        when %w[get post]
          'body ? OpenSearch::API::HTTP_POST : OpenSearch::API::HTTP_GET'
        when %w[post put]
          diff_param = @urls.map { |u| u.split('/').to_set }.sort_by(&:size).reverse.reduce(&:difference).first
          "_#{diff_param[/{(.+)}/, 1]} ? OpenSearch::API::HTTP_PUT : OpenSearch::API::HTTP_POST"
        else
          "OpenSearch::API::HTTP_#{@http_verbs.first.upcase}"
        end
      end

      private

      def parameters
        @parameters ||= @operations.map(&:parameters).flatten.uniq(&:name)
      end
    end
  end
end
