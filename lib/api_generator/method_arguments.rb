# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

module ApiGenerator
  # Logic related to Method Arguments of an Action
  module MethodArguments
    def required_args
      _required.map { |arg| { arg: } }
    end

    def path_args
      @operations.map(&:parameters).map(&:to_a).flatten
                 .select { |p| p['in'] == 'path' }
                 .each_with_object({}) { |p, h| h[p['name']] = p }
                 .map { |name, p| { arg: name, listify: p['x-array'] } }
    end

    def query_args
      sets = @operations.map do |op|
        Set.new(op.parameters.select { |p| p['in'] == 'query' }.map(&:name))
      end
      sets.reduce(&:intersection).map { |arg| { arg: } }
    end

    def valid_params_constant_name
      "#{method_name}_PARAMS".upcase
    end

    def listify_query_args
      @operations.map(&:parameters).map(&:to_a).flatten
                 .select { |p| p['in'] == 'query' && p['x-array'] }
                 .map(&:name).uniq.map { |arg| { arg: } }
    end

    private

    def _required
      @_required ||= @operations.map do |op|
        set = Set.new(op.parameters.select(&:required?).map(&:name))
        set.add('body') if op.request_body&.required?
        set
      end.reduce(&:intersection)
    end
  end
end

