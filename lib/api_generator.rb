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
require_relative 'action'
require_relative 'action_generator'
require_relative 'namespace_generator'
require_relative 'index_generator'

# Generate API endpoints for OpenSearch Ruby client
class ApiGenerator
  HTTP_VERBS = %w[get post put patch delete patch options].freeze
  EXISTING_NAMESPACES = Set.new(%w[
                                  clusters
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
    create_folder_structure(gem_folder)

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
      act_gen = ActionGenerator.new(action)
      if action.namespace.present?
        action_folder = create_folder @actions_folder, action.namespace

        if namespaces.exclude? action.namespace
          namespaces.add action.namespace
          namespace_gen = NamespaceGenerator.new(action.namespace)
          @namespace_folder.join("#{action.namespace}.rb").write(namespace_gen.render)
        end
      else
        action_folder = @actions_folder
      end
      action_folder.join("#{action.name}.rb").write act_gen.render
    end

    @api_folder.join('api.rb').write IndexGenerator.new(namespaces).render
  end

  private

  def create_folder_structure(gem_folder)
    gem_folder = Pathname gem_folder
    lib_folder = create_folder gem_folder, :lib
    opensearch_folder = create_folder lib_folder, :opensearch
    @api_folder = create_folder opensearch_folder, :api
    @actions_folder = create_folder @api_folder, :actions
    @namespace_folder = create_folder @api_folder, :namespace
    # @unit_test_folder = create_folder gem_folder, 'spec/opensearch/api/actions'
  end

  def create_folder(parent, folder_name)
    folder = parent.join folder_name.to_s
    folder.mkpath unless folder.exist?
    folder
  end
end
