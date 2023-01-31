# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

module Opensearch
  module ApiGenerator
    # Logic related to Method Arguments of an Action
    module MethodArguments
      def required_args
        _required.map { |arg| { arg: } }
      end

      def path_args
        [{ arg: :index, listify: true }, { arg: :id }]
      end

      def query_args
        [{ arg: :h }]
      end

      def listify_query_args
        [{ arg: :h }]
      end

      private

      def _required
        operations.map do |op|
          Set.new(op.parameters.select(&:required?).map(&:name))
        end.reduce(&:intersection)
      end
    end
  end
end


