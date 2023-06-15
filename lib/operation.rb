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
require 'openapi3_parser/node/operation'
require_relative 'version'
require_relative 'parameter'

# Wrapper for Openapi3Parser::Node::Operation that adds extra info
class Operation < Openapi3Parser::Node::Operation
  HTTP_VERBS = %w[get post put patch delete patch options].freeze

  attr_reader :url, :http_verb, :group, :namespace, :action,
              :version_added, :version_removed, :version_deprecated

  # @param [string] openapi_spec path to OpenSearch OpenAPI Spec
  # @param [string] version target OpenSearch Version Number (optional)
  def self.grouped_operations(spec_file, version:, groups: nil)
    Openapi3Parser.load_file(spec_file).paths.flat_map do |url, path|
      path.to_h.slice(*HTTP_VERBS).compact.map do |verb, operation_spec|
        operation = new operation_spec, url, verb
        operation.part_of?(version, groups) ? operation : nil
      end
    end.compact.group_by(&:group)
  end

  # @param [Openapi3Parser::Node::Operation] spec Operation Spec
  # @param [String] url
  # @param [String] http_verb
  def initialize(spec, url, http_verb)
    super(spec.node_data, spec.node_context)
    @url = url
    @http_verb = http_verb
    @group = spec['x-operation-group'] || ''
    @action, @namespace = @group.split('.').reverse
    @version_added = Version.new(spec['x-version-added'] || '0.0.0')
    @version_removed = Version.new(spec['x-version-removed'] || '999.999.999')
    @version_deprecated = Version.new spec['x-version-deprecated']
  end

  def parameters
    @parameters ||= super.map { |p| Parameter.new(p) }
  end

  def part_of?(version, groups)
    version = Version.new(version)
    groups.include?(group) && version_added <= version && version < version_removed
  end
end
