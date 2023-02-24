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
require_relative './api_generator/operation'
require_relative './api_generator/action_generator'


# Generate API endpoints for OpenSearch Ruby client
module ApiGenerator
  HTTP_VERBS = %w[get post put patch delete patch options].freeze
  attr_reader :parser, :output_folder

  # @param [string] openapi_spec path to OpenSearch OpenAPI Spec
  # @param [string] output_folder folder to output generated files
  # @param [string] version target OpenSearch version (e.g. 2.5)
  def initialize(openapi_spec, output_folder, version)
    @parser = Openapi3Parser.load_file openapi_spec
    @output_folder = Pathname output_folder
    @version = version
  end

  def generate
    operation_groups.each_value do |operations|
      action = ApiGenerator::ActionGenerator.new(operations)
      puts action.render
    end
  end

  private

  def operation_groups
    parser.paths.map do |url, path|
      path.to_h.slice(*HTTP_VERBS).compact.map do |verb, operation|
        op = ApiGenerator::Operation.new operation, url, verb
        op.part_of?(@version) ? op : nil
      end
    end.flatten.compact.group_by(&:group)
  end

  def create_folder(name)
    folder = @output_folder.join name
    folder.mkdir unless folder.exist?
    folder
  end
end
