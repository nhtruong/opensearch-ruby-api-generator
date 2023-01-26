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

module Opensearch
  # Generate API endpoints for OpenSearch Ruby client
  class ApiGenerator
    attr_reader :parser, :output_folder

    # @param [string] openapi_spec path to OpenSearch OpenAPI Spec
    # @param [string] output_folder folder to output generated files
    def initialize(openapi_spec, output_folder)
      @parser = Openapi3Parser.load_file openapi_spec
      @output_folder = output_folder
    end

    def generate
      parser.paths.each {}
    end

    def generate_one(path, operation); end
  end
end
