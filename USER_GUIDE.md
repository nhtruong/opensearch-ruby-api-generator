This API Generator generates API actions for the OpenSearch Ruby client based off of [OpenSearch OpenAPI specification](https://github.com/opensearch-project/opensearch-api-specification/blob/main/OpenSearch.openapi.json)

---
Install all dependencies
```bash
bundle install
```

Import the API Generator and load the OpenSearch OpenAPI specification into a generator instance
```ruby
require './lib/api_generator'
generator = ApiGenerator.new('./OpenSearch.openapi.json')
```

The `generate` method accepts the path to the root directory of the `opensearch-ruby` gem as a parameter. By default, it points to the parent directory of the folder containing the generator script. For example to generate all actions into the `tmp` directory:
```ruby
generator.generate('./tmp')
```

You can also target a specific API version by passing in the version number as a parameter. For example to generate all actions for version `1.0.0` into the `tmp` directory:
```ruby
generator.generate(version: '1.0.0')
```

The generator also support incremental generation. For example, to generate all actions of the `cat` namespace:
```ruby
generator.generate(namespace: 'cat')
```

To limit it to specific actions of a namespace:
```ruby
generator.generate(namespace: 'cat', actions: %w[aliases allocation])
```

Note that the root namespace is presented by an empty string `''`. For example, to generate all actions of the root namespace for OS version 2.3:
```ruby
generator.generate(version: '2.3', namespace: '')
```
