require './lib/opensearch/api_generator'
require 'awesome_print'
AwesomePrint.irb!

generator = Class.new { include Opensearch::ApiGenerator }.new './api_specs/opensearch.openapi.json', './tmp'
parser = generator.parser
path_item = parser.paths['/_cat/indices/{index}']
operation = path_item.get
# ap operation.parameters.map(&:to_h)[0..1]
# ap operation.parameters.map { |x| x.schema.to_h }[0..1]
require './lib/opensearch/api_generator/action'
action = Opensearch::ApiGenerator::Action.new('/_cat/indices/{index}', 'get', [operation])
output = action.render
puts output
Pathname('./tmp/action.rb').write(output)
