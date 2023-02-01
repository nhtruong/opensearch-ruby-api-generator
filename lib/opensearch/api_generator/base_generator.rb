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
require 'mustache'
require 'active_support/all'

module Opensearch
  module ApiGenerator
    # Base Mustache Generator
    class BaseGenerator < Mustache
      self.template_path = './templates'

      def license_header
        Pathname('./templates/license_header.txt').read
      end

      def generated_code_warning
        "# This code was generated from OpenSearch API Spec.\n" \
          '# Update the code generation logic instead of modifying this file directly.'
      end
    end
  end
end
