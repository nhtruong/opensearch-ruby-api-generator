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
require_relative 'base'

module Opensearch
  module ApiGenerator
    # Logic To Generate an API Method
    class Action < Base
      self.template_file = './templates/action.mustache'

      def namespace
        'Indices'
      end

      def method_documentation
        '# Rdoc documentation'
      end

      def method_name
        'create'
      end

      def required_args
        [{ arg: :index }]
      end

      def path_args
        [{ arg: :index, listify: true }, { arg: :id }]
      end

      def listify_query_args
        [{ arg: :h }]
      end

      def path
        '#{_index}/docs/#{_id}'
      end
    end
  end
end
