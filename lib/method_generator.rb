# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'action'

# Generate an API Method via Mustache
class MethodGenerator < BaseGenerator
  self.template_file = './templates/method.mustache'
  attr_reader :namespace, :doc_namespace, :camelized_namespace, :function_name, :prototype_name,
              :valid_params_constant_name,
              :method_description, :external_docs, :doc_method_name

  # @param [Pathname] output_folder
  # @param [Action] action
  def initialize(output_folder, action)
    super(output_folder)
    @action = action
    @urls = action.urls.map { |u| u.split('/').select(&:present?) }.uniq
    @external_docs = action.external_docs
    @namespace = action.namespace
    @camelized_namespace = @namespace.camelcase
    @doc_namespace = @namespace.titleize.gsub(/\s+/, '')
    @prototype_name = action.name.camelcase(:lower)
    @function_name = "#{@namespace.camelcase(:lower)}#{action.name.camelcase}Api"
    @method_description = action.description
    @doc_method_name = @prototype_name&.titleize
  end

  def argument_descriptions
    @action.parameters.map do |p|
      { data_type: "{#{p.javascript_type}}",
        name: p.required? ? "params.#{p.snake_name}" : "[params.#{p.snake_name}]",
        description: p.description ? " - #{p.description}" : nil,
        default: p.default,
        deprecated: p.deprecated? }
    end
  end

  def required_params
    @action.required_params.map do |p|
      { camel_name: p.camel_name,
        snake_name: p.snake_name,
        has_snake_name: p.many_names }
    end.tap { |args| args.last&.[]=('_blank_line', true) }
  end

  def path_param_names
    @action.path_params.flat_map { |p| p.names.map { |n| { name: n } } }
  end

  def path_param_encodings
    @action.path_params.map { |p| { snake_name: p.snake_name, names: p.names.join(', ') } }
           .tap { |args| args.last&.[]=('_blank_line', true) }
  end

  def url_components
    @urls.max_by(&:length)
         .map { |e| e.starts_with?('{') ? "#{e[/{(.+)}/, 1]}" : "'#{e}'" }
         .prepend("''")
         .join(', ')
  end

  def http_verb
    case @action.http_verbs.sort
    when %w[get post]
      "body ? 'POST' : 'GET'"
    when %w[post put]
      # diff_param = @urls.map(&:to_set).sort_by(&:size).reverse.reduce(&:difference).first
      # "_#{diff_param[/{(.+)}/, 1]} ? OpenSearch::API::HTTP_PUT : OpenSearch::API::HTTP_POST"
      "'PUT'"
    else
      "'#{@action.http_verbs.first.upcase}'"
    end
  end

  private

  def output_file
    create_folder(*[@output_folder, @action.namespace].compact).join("#{@action.name}.js")
  end
end
