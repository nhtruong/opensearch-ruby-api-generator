# require './lib/opensearch/api_generator'
# require 'awesome_print'
# AwesomePrint.irb!
#
# generator = Opensearch::ApiGenerator.new './api_specs/opensearch.openapi.json', './tmp'
# parser = generator.parser
#
# path_item = parser.paths['/{index}']
# operation = path_item.put

###############

require './lib/opensearch/api_generator/action'
output = Opensearch::ApiGenerator::Action.render
puts output
Pathname('./tmp/action.rb').write(output)
