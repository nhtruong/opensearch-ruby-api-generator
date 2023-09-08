# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'method_generator'

# Generate a Namespace file via Mustache
class ModuleGenerator < BaseGenerator
  self.template_file = './templates/module.mustache'
  attr_reader :namespace, :camelized_namespace

  # @param [Pathname] output_folder Output folder
  # @param [String] namespace Namespace name
  # @param [Array<Action>] actions Actions in the namespace
  def initialize(output_folder, namespace, actions)
    super(output_folder)
    @namespace = namespace
    @camelized_namespace = @namespace.camelcase
    @actions = actions
  end

  def query_name_mapping
    @actions.flat_map(&:query_params).uniq(&:name).sort_by(&:name)
            .map { |p| { camel_name: p.camel_name, snake_name: p.snake_name } }
            .reject { |p| p[:camel_name] == p[:snake_name] }
  end

  def method_definitions
    @actions.sort_by(&:name).map do |action|
      MethodGenerator.new(@output_folder, action).render
    end.join("\n\n")
  end

  def method_aliases
    @actions.map(&:name).sort.map do |action_name|
      { camel_name: action_name.camelcase(:lower), snake_name: action_name.underscore }
    end.reject { |p| p[:camel_name] == p[:snake_name] }
  end

  private

  def output_file
    create_folder(@output_folder).join("#{@namespace}.js")
  end
end
