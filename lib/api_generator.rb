# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require 'openapi3_parser'
require_relative 'action'
require_relative 'action_generator'
require_relative 'spec_generator'
require_relative 'namespace_generator'
require_relative 'index_generator'

# Generate API endpoints for OpenSearch Ruby client
class ApiGenerator
  HTTP_VERBS = %w[get post put patch delete patch head].freeze
  EXISTING_NAMESPACES = Set.new(%w[
                                  cluster
                                  nodes
                                  indices
                                  ingest
                                  snapshot
                                  tasks
                                  cat
                                  remote
                                  dangling_indices
                                  features
                                  shutdown
                                ]).freeze

  # @param [String] openapi_spec location of the OpenSearch API spec file [required]
  def initialize(openapi_spec)
    @spec = Openapi3Parser.load_file(openapi_spec)
  end

  # @param [String] output location of the API Gem folder (default to the parent folder of the generator)
  # @param [String] version target OpenSearch version to generate like "2.5" or "3.0"
  # @param [String] namespace namespace to generate (Default to all namespaces. Use '' for root)
  # @param [Array<String>] actions list of actions in the specified namespace to generate (Default to all actions)
  def generate(output = '../', version: nil, namespace: nil, actions: nil)
    gem_folder = Pathname output
    namespaces = EXISTING_NAMESPACES.dup
    target_actions(version, namespace, actions).each do |action|
      ActionGenerator.new(gem_folder + 'lib/opensearch/api/actions', action).generate
      SpecGenerator.new(gem_folder + 'spec/opensearch/api/actions', action).generate
      NamespaceGenerator.new(gem_folder + 'lib/opensearch/api/namespace', action.namespace).generate(namespaces)
    end
    IndexGenerator.new(gem_folder + 'lib/opensearch', namespaces).generate
  end

  private

  def target_actions(version, namespace, actions)
    namespace = namespace.to_s
    actions = Array(actions).map(&:to_s).to_set unless actions.nil?

    operations = @spec.paths.flat_map do |url, path|
      path.to_h.slice(*HTTP_VERBS).compact.map do |verb, operation_spec|
        operation = Operation.new operation_spec, url, verb
        operation.part_of?(version, namespace, actions) ? operation : nil
      end
    end.compact

    operations.group_by(&:group).map { |group, ops| Action.new ops }
  end
end
