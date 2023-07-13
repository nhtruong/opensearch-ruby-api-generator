# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require './lib/opensearch/api_generator'

desc 'Generate API'
task :generate do
  generator = Opensearch::ApiGenerator.new './api_specs/opensearch.openapi.json', './tmp'
  ap generator.generate_one '/{index}', 'put'
end
