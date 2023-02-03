require './lib/opensearch/api_generator'
require './lib/opensearch/api_generator/operation'
require 'awesome_print'
AwesomePrint.irb!

generator = Class.new { include Opensearch::ApiGenerator }.new './api_specs/opensearch.openapi.json', './tmp'
parser = generator.parser
path_item = parser.paths['/_cat/indices/{index}']
operation = path_item.get

op1 = Opensearch::ApiGenerator::Operation.new(operation, '/_cat/indices/{index}', 'get')
op2 = Opensearch::ApiGenerator::Operation.new(operation, '/_cat/indices/{index}', 'post')

require './lib/opensearch/api_generator/action_generator'
action = Opensearch::ApiGenerator::ActionGenerator.new([op1, op2])
output = action.render
puts output
Pathname('./tmp/action.rb').write(output)
