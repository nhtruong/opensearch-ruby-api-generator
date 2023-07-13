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

  # @param [string] @gem_folder location of the API Gem folder
  # @param [string] version target OpenSearch version (e.g. 2.5)
  # @param [Array<String>] groups list of operation groups to generate (optional)
  def initialize(openapi_spec, gem_folder, version:, groups: nil)
    @gem_folder = Pathname gem_folder
    operations = Openapi3Parser.load_file(openapi_spec).paths.flat_map do |url, path|
      path.to_h.slice(*HTTP_VERBS).compact.map do |verb, operation_spec|
        operation = Operation.new operation_spec, url, verb
        operation.part_of?(version, groups) ? operation : nil
      end
    end.compact

    @actions = operations.group_by(&:group).map { |group, ops| Action.new group, ops }
  end

  def generate
    namespaces = EXISTING_NAMESPACES.dup
    @actions.each do |action|
      ActionGenerator.new(@gem_folder + 'lib/opensearch/api/actions', action).generate
      SpecGenerator.new(@gem_folder + 'spec/opensearch/api/actions', action).generate
      NamespaceGenerator.new(@gem_folder + 'lib/opensearch/api/namespace', action.namespace).generate(namespaces)
    end
    IndexGenerator.new(@gem_folder + 'lib/opensearch', namespaces).generate
  end
end
