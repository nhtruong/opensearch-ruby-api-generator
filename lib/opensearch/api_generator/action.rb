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
    # Logic To Generate an API Action
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

      def required_arguments
        [{ arg: :index }, { arg: :id }]
      end
    end
  end
end
