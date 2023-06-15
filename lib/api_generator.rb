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
require_relative 'operation'
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
  attr_reader :parser

  # @param [string] openapi_spec path to OpenSearch OpenAPI Spec
  # @param [string] @gem_folder location of the API Gem folder
  # @param [string] version target OpenSearch version (e.g. 2.5)
  def initialize(openapi_spec, gem_folder, version)
    @parser = Openapi3Parser.load_file openapi_spec
    @gem_folder = Pathname gem_folder
    @version = version

    create_folder_structure
  end

  # @param [Array<String>] group_names list of operation groups to generate. Leave blank to generate all.
  def generate(group_names = nil)
    namespaces = EXISTING_NAMESPACES.dup

    operation_groups.each do |group_name, operations|
      next if group_names && !group_names.include?(group_name)

      act_gen = ActionGenerator.new(operations)
      # unit_test_gen = UnitTest::Generator.new(act_gen)
      if act_gen.namespace.present?
        action_folder = create_folder @actions_folder, act_gen.namespace
        unit_test_folder = create_folder @unit_test_folder, act_gen.namespace

        if namespaces.exclude? act_gen.namespace
          namespaces.add act_gen.namespace
          namespace_gen = NamespaceGenerator.new(act_gen.namespace)
          @namespace_folder.join("#{act_gen.namespace}.rb").write(namespace_gen.render)
        end
      else
        action_folder = @actions_folder
        unit_test_folder = @unit_test_folder
      end
      action_folder.join("#{act_gen.action}.rb").write act_gen.render
      # unit_test_folder.join("#{act_gen.action}_spec.rb").write unit_test_gen.render
    end

    @api_folder.join('api.rb').write IndexGenerator.new(namespaces).render
  end

  private

  def operation_groups
    parser.paths.map do |url, path|
      path.to_h.slice(*HTTP_VERBS).compact.map do |verb, operation_spec|
        operation = Operation.new operation_spec, url, verb
        operation.part_of?(@version) ? operation : nil
      end
    end.flatten.compact.group_by(&:group)
  end

  def create_folder_structure
    lib_folder = create_folder @gem_folder, :lib
    opensearch_folder = create_folder lib_folder, :opensearch
    @api_folder = create_folder opensearch_folder, :api
    @actions_folder = create_folder @api_folder, :actions
    @namespace_folder = create_folder @api_folder, :namespace
    @unit_test_folder = create_folder @gem_folder, 'spec/opensearch/api/actions'
  end

  def create_folder(parent, folder_name)
    folder = parent.join folder_name.to_s
    folder.mkpath unless folder.exist?
    folder
  end
end
