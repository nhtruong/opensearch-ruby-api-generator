# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

module Api
  module Action
    # Logic related to Method Arguments of an Action
    module MethodArguments
      def required_args
        _required.map { |arg| { arg: } }
      end

      def path_params
        parameters.select(&:in_path?).map { |p| { name: p.name, listify: p.array? } }
      end

      def query_params
        parameters.select(&:in_query?).map { |p| { name: p.name } }
      end

      def listify_query_params
        parameters.select(&:in_query?).select(&:array?).map { |p| { name: p.name } }
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
end

