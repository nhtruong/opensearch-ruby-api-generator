# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

require_relative 'operation'
require_relative 'version'
require_relative 'parameter'

# A collection of operations that comprise a single API Action
class Action
  attr_reader :group, :name, :namespace, :http_verbs, :urls, :description, :external_docs,
              :parameters, :path_params, :query_params,
              :body, :body_description, :body_required

  # @group [String] operation_group
  # @param [Array<Operation>] operations
  def initialize(group, operations)
    @group = group
    @name, @namespace = group.split('.').reverse
    @operations = operations
    @http_verbs = operations.map(&:http_verb).uniq
    @urls = operations.map(&:url).uniq
    @description = operations.map(&:description).find(&:present?)
    @external_docs = operations.map(&:external_docs).find(&:present?)
    @external_docs = nil if @external_docs == 'https://opensearch.org/docs/latest'
    @body = operations.map(&:request_body).find(&:present?)
    @parameters = operations.flat_map(&:parameters).uniq(&:name)
    @path_params = @parameters.select { |p| p.in == 'path' }
    @query_params = @parameters.select { |p| p.in == 'query' }

    @parameters.each { |p| p.spec.node_data['required'] = p.name.in?(required_components) }
    @body_required = 'body'.in?(required_components)
    @body_description = @body.content['application/json'].schema.description if @body.present?
  end

  def required_components
    @required_components ||= @operations.map do |op|
      set = Set.new(op.parameters.select(&:required?).map(&:name))
      set.add('body') if op.request_body&.required?
      set
    end.reduce(&:intersection)
  end
end
