# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'action'

# Generate Spec test for an API Action via Mustache
class SpecGenerator < BaseGenerator
  self.template_file = './templates/spec.mustache'
  attr_reader :action, :http_verb
  delegate :namespace, :name, to: :action

  # @param [Pathname] output_folder
  # @param [Action] action
  def initialize(output_folder, action)
    super(output_folder)
    @action = action
    @http_verb = action.http_verbs.sort.first.upcase
  end

  def url_path
    action.urls.max_by(&:length).split('/').select(&:present?).map do |component|
      next component unless component.start_with?('{')
      param = action.path_params.find { |p| p.name == component[/{(.+)}/, 1] }
      param.example_value standalone: false
    end.join('/')
  end

  def query_params
    action.query_params.map do |p|
      { pre: ' ',
        key: p.name,
        value: p.example_value,
        post: ',' }
    end.tap do |params|
      params.first&.update(pre: '{ ')
      params.last&.update(post: ' },')
    end
  end

  def body
    return '{}' if action.required_components.include?('body')
    return 'nil' if action.body.nil?
    http_verb.in?(%w[PUT POST PATCH]) ? '{}' : 'nil'
  end

  def required_components
    action.required_components.map do |component|
      { arg: component,
        others: other_required_components(component) }
    end.tap do |components|
      components.last.update(blank_line: true)
    end
  end

  private

  def other_required_components(component)
    action.required_components.reject { |c| c == component }.map do |c|
      "#{c}: #{arg_value(c)}"
    end.join(', ')
  end

  def arg_value(component)
    return body if component == 'body'
    action.path_params.find { |p| p.name == component }&.example_value
  end

  def output_file
    create_folder(*[@output_folder, @action.namespace].compact).join("#{@action.name}_spec.rb")
  end
end
