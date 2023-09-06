# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'action'

# Generate an API Action via Mustache
class ActionGenerator < BaseGenerator
  self.template_file = './templates/action.mustache'
  attr_reader :namespace, :capitalized_namespace, :method_name, :valid_params_constant_name,
              :method_description, :argument_descriptions, :external_docs

  # @param [Pathname] output_folder
  # @param [Action] action
  def initialize(output_folder, action)
    super(output_folder)
    @action = action
    @urls = action.urls.map { |u| u.split('/').select(&:present?) }.uniq
    @external_docs = action.external_docs
    @namespace = action.namespace
    @capitalized_namespace = @namespace.titleize.gsub(/\s+/, '')
    @method_name = action.name.underscore
    @valid_params_constant_name = "#{action.name.upcase}_QUERY_PARAMS"
    @method_description = action.description
    @argument_descriptions = params_desc + [body_desc].compact
  end

  def url_components
    @urls.max_by(&:length)
         .map { |e| e.starts_with?('{') ? "_#{e[/{(.+)}/, 1]}" : "'#{e}'" }
         .join(', ')
  end

  def http_verb
    case @action.http_verbs.sort
    when %w[get post]
      'body ? OpenSearch::API::HTTP_POST : OpenSearch::API::HTTP_GET'
    when %w[post put]
      diff_param = @urls.map(&:to_set).sort_by(&:size).reverse.reduce(&:difference).first
      "_#{diff_param[/{(.+)}/, 1]} ? OpenSearch::API::HTTP_PUT : OpenSearch::API::HTTP_POST"
    else
      "OpenSearch::API::HTTP_#{@action.http_verbs.first.upcase}"
    end
  end

  def required_args
    @action.required_components.map { |arg| { arg: } }
           .tap { |args| args.last&.[]=('_blank_line', true) }
  end

  def path_params
    @action.path_params.map { |p| { name: p.name, listify: p.is_array } }
           .tap { |args| args.last&.[]=('_blank_line', true) }
  end

  def query_params
    @action.query_params.map { |p| { name: p.name } }
  end

  def listify_query_params
    @action.query_params.select(&:is_array).map { |p| { name: p.name } }
           .tap { |args| args.first&.[]=('_blank_line', true) }
  end

  def perform_request
    args = 'method, url, params, body, headers'
    return "perform_request_simple_ignore404(#{args})" if SIMPLE_IGNORE_404.include?(@action.group)
    return "perform_request_complex_ignore404(#{args}, arguments)" if COMPLEX_IGNORE_404.include?(@action.group)
    return "perform_request_ping(#{args})" if PING.include?(@action.group)
    "perform_request(#{args}).body"
  end

  private

  def output_file
    create_folder(*[@output_folder, @action.namespace].compact).join("#{@action.name}.js")
  end

  def params_desc
    @action.parameters.map do |p|
      { data_type: "{#{p.javascript_type}}",
        name: p.required? ? "[params.#{p.name}]" : "params.#{p.name}",
        description: p.description.present? ? " - #{p.description}" : nil,
        default: p.default,
        deprecated: p.deprecated? }
    end
  end

  def body_desc
    return unless @action.body.present?
    { data_type: '{Object}',
      name: @action.body_required ? '[params.body]' : 'params.body',
      description: @action.body_description,
      required: @action.body_required }
  end
end
