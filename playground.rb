require './lib/api/generator'
require './lib/api/operation'
require './lib/api/version'
require 'awesome_print'
AwesomePrint.irb!

# generator = Class.new { include Opensearch::ApiGenerator }.new './api_specs/opensearch.openapi.json', './poc', '2.5'
# parser = generator.parser
# path_item = parser.paths['/_cat/indices/{index}']
# operation = path_item
#
# op1 = Opensearch::ApiGenerator::Operation.new(operation, '/_cat/indices/{index}', 'get')
# op2 = Opensearch::ApiGenerator::Operation.new(operation, '/_cat/indices/{index}', 'post')
#
# require './lib/opensearch/api_generator/action_generator'
# action = Opensearch::ApiGenerator::ActionGenerator.new([op1])
# output = action.render
# puts output
# Pathname('./poc/action.rb').write(output)


generator = Api::Generator.new './api_specs/opensearch.openapi.json', './poc', '2.5'
generator.generate(%w[remote_store.restore index field_caps])
