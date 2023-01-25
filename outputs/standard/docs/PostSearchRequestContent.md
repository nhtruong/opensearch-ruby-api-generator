# OpenapiClient::PostSearchRequestContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **docvalue_fields** | **String** |  | [optional] |
| **explain** | **Boolean** |  | [optional] |
| **from** | **Integer** |  | [optional] |
| **seq_no_primary_term** | **Boolean** |  | [optional] |
| **size** | **Integer** |  | [optional] |
| **source** | **String** |  | [optional] |
| **stats** | **String** |  | [optional] |
| **terminate_after** | **Integer** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **version** | **Boolean** |  | [optional] |
| **fields** | **Array&lt;String&gt;** |  | [optional] |
| **min_score** | **Integer** |  | [optional] |
| **indices_boost** | **Array&lt;Object&gt;** |  | [optional] |
| **query** | [**UserDefinedObjectStructure**](UserDefinedObjectStructure.md) |  | [optional] |

## Example

```ruby
require 'openapi_client'

instance = OpenapiClient::PostSearchRequestContent.new(
  docvalue_fields: null,
  explain: null,
  from: null,
  seq_no_primary_term: null,
  size: null,
  source: null,
  stats: null,
  terminate_after: null,
  timeout: null,
  version: null,
  fields: null,
  min_score: null,
  indices_boost: null,
  query: null
)
```

