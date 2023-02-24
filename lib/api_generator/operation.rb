# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

require 'openapi3_parser/node/operation'
require_relative 'version'

module ApiGenerator
  # Wrapper for Openapi3Parser::Node::Operation that adds extra info
  class Operation < Openapi3Parser::Node::Operation
    attr_reader :url, :http_verb, :group, :namespace, :action,
                :version_added, :version_removed, :version_deprecated

    # @param [Openapi3Parser::Node::Operation] operation
    # @param [String] url
    # @param [String] http_verb
    def initialize(operation, url, http_verb)
      super(operation.node_data, operation.node_context)
      @url = url
      @http_verb = http_verb
      @group = operation['x-operation-group'] || ''
      @action, @namespace = @group.split('.').reverse
      @version_added = Version.new operation['x-version-added']
      @version_removed = Version.new operation['x-version-removed']
      @version_deprecated = Version.new operation['x-version-deprecated']
    end

    # @param [string] version OpenSearch Version Number
    def part_of?(version)
      return false if version_added.nil? && version_removed.nil?
      version = Version.new(version)
      version_added <= version && (version_removed.nil? || version <= version_removed)
    end
  end
end
