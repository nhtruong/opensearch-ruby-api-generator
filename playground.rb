# frozen_string_literal: true

require './lib/api_generator'

generator = ApiGenerator.new './api_specs/opensearch.openapi.json'
generator.generate '../../IdeaProjects/opensearch-js', namespace: 'security'
