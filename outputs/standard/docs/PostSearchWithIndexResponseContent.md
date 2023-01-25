# OpenapiClient::PostSearchWithIndexResponseContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_scroll_id** | **String** |  | [optional] |
| **took** | **Integer** |  | [optional] |
| **timed_out** | **Boolean** |  | [optional] |
| **_shards** | [**ShardStatistics**](ShardStatistics.md) |  | [optional] |
| **hits** | [**HitsMetadata**](HitsMetadata.md) |  | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::PostSearchWithIndexResponseContent.new(
  _scroll_id: null,
  took: null,
  timed_out: null,
  _shards: null,
  hits: null
)
```

