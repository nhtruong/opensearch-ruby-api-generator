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

module Api
  module Action
    # Logic To Generate an API Action via Mustache
    class Generator < BaseGenerator
      self.template_file = './templates/action.mustache'
      attr_reader :namespace, :action, :operations,
                  :module_name, :method_name, :valid_params_constant_name,
                  :method_description, :argument_descriptions

      # @param [Array<Api::Operation>] operations
      def initialize(operations)
        @operations = operations
        @namespace = operations.first&.namespace
        @action = operations.first&.action
        @http_verbs = operations.map(&:http_verb)
        @urls = operations.map(&:url).map { |u| u.split('/').select(&:present?) }.uniq

        @module_name = namespace&.camelize
        @method_name = action.underscore
        @valid_params_constant_name = "#{method_name.upcase}_QUERY_PARAMS"
        @method_description = operations.first&.description
        @argument_descriptions = params_desc + [body_desc].compact
        super
      end

      def url_components
        @urls.max_by(&:length)
             .map { |e| e.starts_with?('{') ? "_#{e[/{(.+)}/, 1]}" : "'#{e}'" }
             .join(', ')
      end

      def http_verb
        case @http_verbs.uniq.sort
        when %w[get post]
          'body ? OpenSearch::API::HTTP_POST : OpenSearch::API::HTTP_GET'
        when %w[post put]
          diff_param = @urls.map(&:to_set).sort_by(&:size).reverse.reduce(&:difference).first
          "_#{diff_param[/{(.+)}/, 1]} ? OpenSearch::API::HTTP_PUT : OpenSearch::API::HTTP_POST"
        else
          "OpenSearch::API::HTTP_#{@http_verbs.first.upcase}"
        end
      end

      def required_args
        _required.map { |arg| { arg: } }
                 .tap { |args| args.last&.[]=('_blank_line', true) }
      end

      def path_params
        parameters.select(&:in_path?).map { |p| { name: p.name, listify: p.array? } }
                  .tap { |args| args.last&.[]=('_blank_line', true) }
      end

      def query_params
        parameters.select(&:in_query?).map { |p| { name: p.name } }
      end

      def listify_query_params
        parameters.select(&:in_query?).select(&:array?).map { |p| { name: p.name } }
                  .tap { |args| args.first&.[]=('_blank_line', true) }
      end

      private

      def parameters
        @parameters ||= operations.map(&:parameters).flatten.uniq(&:name)
      end

      def _required
        @_required ||= operations.map do |op|
          set = Set.new(op.parameters.select(&:required?).map(&:name))
          set.add('body') if op.request_body&.required?
          set
        end.reduce(&:intersection)
      end

      def params_desc
        parameters.map do |p|
          { data_type: p.ruby_type,
            name: p.name,
            required: p.name.in?(_required),
            description: p.description,
            default: p.default,
            deprecated: p.deprecated? }
        end
      end

      def body_desc
        body = operations.map(&:request_body).find(&:present?)
        { data_type: :Hash,
          name: :body,
          required: 'body'.in?(_required),
          description: body.description } unless body.nil?
      end
    end
  end
end
