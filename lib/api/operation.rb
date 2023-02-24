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

module Api
  # Wrapper for Openapi3Parser::Node::Operation that adds extra info
  class Operation < Openapi3Parser::Node::Operation
    attr_reader :url, :http_verb, :group, :namespace, :action,
                :version_added, :version_removed, :version_deprecated

    # @param [Openapi3Parser::Node::Operation] spec
    # @param [String] url
    # @param [String] http_verb
    def initialize(spec, url, http_verb)
      super(spec.node_data, spec.node_context)
      @url = url
      @http_verb = http_verb
      @group = spec['x-operation-group'] || ''
      @action, @namespace = @group.split('.').reverse
      @version_added = Version.new spec['x-version-added']
      @version_removed = Version.new spec['x-version-removed']
      @version_deprecated = Version.new spec['x-version-deprecated']
    end

    # @param [string] version OpenSearch Version Number
    def part_of?(version)
      return false if version_added.nil? && version_removed.nil?
      version = Version.new(version)
      version_added <= version && (version_removed.nil? || version <= version_removed)
    end
  end
end
