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
require_relative 'base_generator'

# Generate the index file via Mustache
class IndexGenerator < BaseGenerator
  self.template_file = './templates/index.mustache'

  def initialize(namespaces)
    @namespaces = Set.new namespaces
    super
  end

  def legacy_license_header
    Pathname('./templates/legacy_license_header.txt').read
  end

  def namespace_modules
    modules = @namespaces.to_a.sort.map do |namespace|
      { name: "OpenSearch::API::#{namespace.camelcase}", comma: ',' }
    end
    modules.last[:comma] = ''
    modules
  end
end
