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
require_relative './action/generator'
require_relative './namespace/generator'
require_relative './index/generator'

module Api
  # Generate API endpoints for OpenSearch Ruby client
  class Generator
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
    attr_reader :parser, :gem_folder, :opensearch_folder, :api_folder, :actions_folder, :namespace_folder

    # @param [string] openapi_spec path to OpenSearch OpenAPI Spec
    # @param [string] @gem_folder location of the API Gem folder
    # @param [string] version target OpenSearch version (e.g. 2.5)
    def initialize(openapi_spec, gem_folder, version)
      @parser = Openapi3Parser.load_file openapi_spec
      @gem_folder = Pathname gem_folder
      @version = version

      create_folder_structure
    end

    def generate
      namespaces = EXISTING_NAMESPACES.dup

      operation_groups.each_value do |operations|
        action = Action::Generator.new(operations)
        output = create_folder actions_folder, action.namespace
        output.join("#{action.action}.rb").write action.render

        unless namespaces.include? action.namespace
          namespace = Namespace::Generator.new(action.namespace)
          namespace_folder.join("#{action.namespace}.rb").write(namespace.render)
        end
        namespaces.add action.namespace
      end

      api_folder.join('api.rb').write Index::Generator.new(namespaces).render
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
      lib_folder = create_folder gem_folder, :lib
      @opensearch_folder = create_folder lib_folder, :opensearch
      @api_folder = create_folder opensearch_folder, :api
      @actions_folder = create_folder api_folder, :actions
      @namespace_folder = create_folder api_folder, :namespace
    end

    def create_folder(parent, folder_name)
      folder = parent.join folder_name.to_s
      folder.mkdir unless folder.exist?
      folder
    end
  end
end
