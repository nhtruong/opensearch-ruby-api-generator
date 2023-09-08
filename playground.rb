require './lib/api_generator'
require './lib/operation'
require './lib/version'
require 'awesome_print'
AwesomePrint.irb!


generator = ApiGenerator.new './api_specs/opensearch.openapi.json'
generator.generate './tmp', namespace: 'indices'
