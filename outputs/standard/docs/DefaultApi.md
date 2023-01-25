# OpenapiClient::DefaultApi

All URIs are relative to *http://localhost*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**delete_index**](DefaultApi.md#delete_index) | **DELETE** /{index} |  |
| [**get_cat_indices**](DefaultApi.md#get_cat_indices) | **GET** /_cat/indices |  |
| [**get_cat_indices_with_index**](DefaultApi.md#get_cat_indices_with_index) | **GET** /_cat/indices/{index} |  |
| [**get_cat_nodes**](DefaultApi.md#get_cat_nodes) | **GET** /_cat/nodes |  |
| [**get_cluster_info**](DefaultApi.md#get_cluster_info) | **GET** / |  |
| [**get_cluster_settings**](DefaultApi.md#get_cluster_settings) | **GET** /_cluster/settings |  |
| [**get_document_doc**](DefaultApi.md#get_document_doc) | **GET** /{index}/_doc/{id} |  |
| [**get_document_source**](DefaultApi.md#get_document_source) | **GET** /{index}/_source/{id} |  |
| [**get_settings_index**](DefaultApi.md#get_settings_index) | **GET** /{index}/_settings |  |
| [**get_settings_index_setting**](DefaultApi.md#get_settings_index_setting) | **GET** /{index}/_settings/{setting} |  |
| [**post_aliases**](DefaultApi.md#post_aliases) | **POST** /_aliases |  |
| [**post_search**](DefaultApi.md#post_search) | **POST** /_search |  |
| [**post_search_with_index**](DefaultApi.md#post_search_with_index) | **POST** /{index}/_search |  |
| [**put_create_index**](DefaultApi.md#put_create_index) | **PUT** /{index} |  |
| [**put_index_mapping_with_index**](DefaultApi.md#put_index_mapping_with_index) | **PUT** /{index}/_mapping |  |
| [**put_update_cluster_settings**](DefaultApi.md#put_update_cluster_settings) | **PUT** /_cluster/settings |  |


## delete_index

> <DeleteIndexResponseContent> delete_index(index, opts)



Removes a document from the index.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  allow_no_indices: true, # Boolean | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  ignore_unavailable: true, # Boolean | 
  timeout: 'timeout_example' # String | 
}

begin
  
  result = api_instance.delete_index(index, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->delete_index: #{e}"
end
```

#### Using the delete_index_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteIndexResponseContent>, Integer, Hash)> delete_index_with_http_info(index, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.delete_index_with_http_info(index, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteIndexResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->delete_index_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **allow_no_indices** | **Boolean** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **ignore_unavailable** | **Boolean** |  | [optional] |
| **timeout** | **String** |  | [optional] |

### Return type

[**DeleteIndexResponseContent**](DeleteIndexResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_cat_indices

> Object get_cat_indices(opts)



Returns information about indices: number of primaries and replicas, document counts, disk size, etc.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  bytes: 56, # Integer | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  health: OpenapiClient::HealthStatus::GREEN, # HealthStatus | 
  include_unloaded_segments: true, # Boolean | 
  pri: true, # Boolean | 
  time: 'time_example', # String | 
  format: 'format_example' # String | 
}

begin
  
  result = api_instance.get_cat_indices(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cat_indices: #{e}"
end
```

#### Using the get_cat_indices_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> get_cat_indices_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_cat_indices_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cat_indices_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **bytes** | **Integer** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **health** | [**HealthStatus**](.md) |  | [optional] |
| **include_unloaded_segments** | **Boolean** |  | [optional] |
| **pri** | **Boolean** |  | [optional] |
| **time** | **String** |  | [optional] |
| **format** | **String** |  | [optional] |

### Return type

**Object**

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_cat_indices_with_index

> Object get_cat_indices_with_index(index, opts)



Returns information about indices: number of primaries and replicas, document counts, disk size, etc.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  bytes: 56, # Integer | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  health: OpenapiClient::HealthStatus::GREEN, # HealthStatus | 
  include_unloaded_segments: true, # Boolean | 
  pri: true, # Boolean | 
  time: 'time_example', # String | 
  format: 'format_example' # String | 
}

begin
  
  result = api_instance.get_cat_indices_with_index(index, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cat_indices_with_index: #{e}"
end
```

#### Using the get_cat_indices_with_index_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> get_cat_indices_with_index_with_http_info(index, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_cat_indices_with_index_with_http_info(index, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cat_indices_with_index_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **bytes** | **Integer** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **health** | [**HealthStatus**](.md) |  | [optional] |
| **include_unloaded_segments** | **Boolean** |  | [optional] |
| **pri** | **Boolean** |  | [optional] |
| **time** | **String** |  | [optional] |
| **format** | **String** |  | [optional] |

### Return type

**Object**

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_cat_nodes

> Object get_cat_nodes(opts)



Returns basic statistics about performance of cluster nodes.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  bytes: 56, # Integer | 
  full_id: true, # Boolean | 
  local: true, # Boolean | 
  time: 'time_example', # String | 
  include_unloaded_segments: true, # Boolean | 
  format: 'format_example' # String | 
}

begin
  
  result = api_instance.get_cat_nodes(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cat_nodes: #{e}"
end
```

#### Using the get_cat_nodes_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> get_cat_nodes_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_cat_nodes_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cat_nodes_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **bytes** | **Integer** |  | [optional] |
| **full_id** | **Boolean** |  | [optional] |
| **local** | **Boolean** |  | [optional] |
| **time** | **String** |  | [optional] |
| **include_unloaded_segments** | **Boolean** |  | [optional] |
| **format** | **String** |  | [optional] |

### Return type

**Object**

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_cluster_info

> <GetClusterInfoResponseContent> get_cluster_info



Returns whether the cluster is running.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new

begin
  
  result = api_instance.get_cluster_info
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cluster_info: #{e}"
end
```

#### Using the get_cluster_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetClusterInfoResponseContent>, Integer, Hash)> get_cluster_info_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_cluster_info_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetClusterInfoResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cluster_info_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetClusterInfoResponseContent**](GetClusterInfoResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_cluster_settings

> <GetClusterSettingsResponseContent> get_cluster_settings(opts)



Returns cluster settings.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  flat_settings: true, # Boolean | 
  include_defaults: true # Boolean | 
}

begin
  
  result = api_instance.get_cluster_settings(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cluster_settings: #{e}"
end
```

#### Using the get_cluster_settings_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetClusterSettingsResponseContent>, Integer, Hash)> get_cluster_settings_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_cluster_settings_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetClusterSettingsResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_cluster_settings_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **flat_settings** | **Boolean** |  | [optional] |
| **include_defaults** | **Boolean** |  | [optional] |

### Return type

[**GetClusterSettingsResponseContent**](GetClusterSettingsResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_document_doc

> <GetDocumentDocResponseContent> get_document_doc(index, id, opts)



Returns a document

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
id = '1' # String | 
opts = {
  preference: 'preference_example', # String | 
  realtime: true, # Boolean | 
  refresh: true, # Boolean | 
  routing: 'routing_example', # String | 
  stored_fields: true, # Boolean | 
  _source: '_source_example', # String | 
  _source_excludes: '_source_excludes_example', # String | 
  _source_includes: '_source_includes_example', # String | 
  version: 56, # Integer | 
  version_type: OpenapiClient::VersionType::INTERNAL # VersionType | 
}

begin
  
  result = api_instance.get_document_doc(index, id, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_document_doc: #{e}"
end
```

#### Using the get_document_doc_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetDocumentDocResponseContent>, Integer, Hash)> get_document_doc_with_http_info(index, id, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_document_doc_with_http_info(index, id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetDocumentDocResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_document_doc_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **id** | **String** |  |  |
| **preference** | **String** |  | [optional] |
| **realtime** | **Boolean** |  | [optional] |
| **refresh** | **Boolean** |  | [optional] |
| **routing** | **String** |  | [optional] |
| **stored_fields** | **Boolean** |  | [optional] |
| **_source** | **String** |  | [optional] |
| **_source_excludes** | **String** |  | [optional] |
| **_source_includes** | **String** |  | [optional] |
| **version** | **Integer** |  | [optional] |
| **version_type** | [**VersionType**](.md) |  | [optional] |

### Return type

[**GetDocumentDocResponseContent**](GetDocumentDocResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_document_source

> get_document_source(index, id, opts)



Returns a document.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
id = '1' # String | 
opts = {
  preference: 'preference_example', # String | 
  realtime: true, # Boolean | 
  refresh: true, # Boolean | 
  routing: 'routing_example', # String | 
  stored_fields: true, # Boolean | 
  _source: '_source_example', # String | 
  _source_excludes: '_source_excludes_example', # String | 
  _source_includes: '_source_includes_example', # String | 
  version: 56, # Integer | 
  version_type: OpenapiClient::VersionType::INTERNAL # VersionType | 
}

begin
  
  api_instance.get_document_source(index, id, opts)
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_document_source: #{e}"
end
```

#### Using the get_document_source_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> get_document_source_with_http_info(index, id, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_document_source_with_http_info(index, id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_document_source_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **id** | **String** |  |  |
| **preference** | **String** |  | [optional] |
| **realtime** | **Boolean** |  | [optional] |
| **refresh** | **Boolean** |  | [optional] |
| **routing** | **String** |  | [optional] |
| **stored_fields** | **Boolean** |  | [optional] |
| **_source** | **String** |  | [optional] |
| **_source_excludes** | **String** |  | [optional] |
| **_source_includes** | **String** |  | [optional] |
| **version** | **Integer** |  | [optional] |
| **version_type** | [**VersionType**](.md) |  | [optional] |

### Return type

nil (empty response body)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## get_settings_index

> Object get_settings_index(index, opts)



The get settings API operation returns all the settings in your index.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  allow_no_indices: true, # Boolean | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  flat_settings: true, # Boolean | 
  include_defaults: 'include_defaults_example', # String | 
  ignore_unavailable: true, # Boolean | 
  local: true # Boolean | 
}

begin
  
  result = api_instance.get_settings_index(index, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_settings_index: #{e}"
end
```

#### Using the get_settings_index_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> get_settings_index_with_http_info(index, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_settings_index_with_http_info(index, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_settings_index_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **allow_no_indices** | **Boolean** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **flat_settings** | **Boolean** |  | [optional] |
| **include_defaults** | **String** |  | [optional] |
| **ignore_unavailable** | **Boolean** |  | [optional] |
| **local** | **Boolean** |  | [optional] |

### Return type

**Object**

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_settings_index_setting

> Object get_settings_index_setting(index, setting, opts)



The get settings API operation returns all the settings in your index.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
setting = 'index' # String | 
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  allow_no_indices: true, # Boolean | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  flat_settings: true, # Boolean | 
  include_defaults: 'include_defaults_example', # String | 
  ignore_unavailable: true, # Boolean | 
  local: true # Boolean | 
}

begin
  
  result = api_instance.get_settings_index_setting(index, setting, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_settings_index_setting: #{e}"
end
```

#### Using the get_settings_index_setting_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> get_settings_index_setting_with_http_info(index, setting, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_settings_index_setting_with_http_info(index, setting, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->get_settings_index_setting_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **setting** | **String** |  |  |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **allow_no_indices** | **Boolean** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **flat_settings** | **Boolean** |  | [optional] |
| **include_defaults** | **String** |  | [optional] |
| **ignore_unavailable** | **Boolean** |  | [optional] |
| **local** | **Boolean** |  | [optional] |

### Return type

**Object**

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## post_aliases

> <PostAliasesResponseContent> post_aliases(opts)



Adds or removes index aliases.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  timeout: 'timeout_example', # String | 
  post_aliases_request_content: OpenapiClient::PostAliasesRequestContent.new # PostAliasesRequestContent | 
}

begin
  
  result = api_instance.post_aliases(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->post_aliases: #{e}"
end
```

#### Using the post_aliases_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PostAliasesResponseContent>, Integer, Hash)> post_aliases_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.post_aliases_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PostAliasesResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->post_aliases_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **post_aliases_request_content** | [**PostAliasesRequestContent**](PostAliasesRequestContent.md) |  | [optional] |

### Return type

[**PostAliasesResponseContent**](PostAliasesResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## post_search

> <PostSearchResponseContent> post_search(opts)



Returns results matching a query.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  allow_no_indices: true, # Boolean | 
  allow_partial_search_results: true, # Boolean | 
  analyzer: 'analyzer_example', # String | 
  analyze_wildcard: true, # Boolean | 
  batched_reduce_size: 56, # Integer | 
  ccs_minimize_roundtrips: true, # Boolean | 
  default_operator: OpenapiClient::DefaultOperator::AND, # DefaultOperator | 
  df: 'df_example', # String | 
  docvalue_fields: 'docvalue_fields_example', # String | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  explain: true, # Boolean | 
  from: 56, # Integer | 
  ignore_throttled: true, # Boolean | 
  ignore_unavailable: true, # Boolean | 
  lenient: true, # Boolean | 
  max_concurrent_shard_requests: 789, # Integer | 
  pre_filter_shard_size: 789, # Integer | 
  preference: 'preference_example', # String | 
  q: 'q_example', # String | 
  request_cache: true, # Boolean | 
  rest_total_hits_as_int: true, # Boolean | 
  routing: 'routing_example', # String | 
  scroll: '1d', # String | 
  search_type: OpenapiClient::SearchType::N0, # SearchType | 
  seq_no_primary_term: true, # Boolean | 
  size: 56, # Integer | 
  sort: ['inner_example'], # Array<String> | 
  source: 'source_example', # String | 
  source_excludes: ['inner_example'], # Array<String> | 
  source_includes: ['inner_example'], # Array<String> | 
  stats: 'stats_example', # String | 
  stored_fields: true, # Boolean | 
  suggest_field: 'suggest_field_example', # String | 
  suggest_mode: OpenapiClient::SuggestMode::N0, # SuggestMode | 
  suggest_size: 789, # Integer | 
  suggest_text: 'suggest_text_example', # String | 
  terminate_after: 56, # Integer | 
  timeout: 'timeout_example', # String | 
  track_scores: true, # Boolean | 
  track_total_hits: 56, # Integer | 
  typed_keys: true, # Boolean | 
  version: true, # Boolean | 
  post_search_request_content: OpenapiClient::PostSearchRequestContent.new # PostSearchRequestContent | 
}

begin
  
  result = api_instance.post_search(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->post_search: #{e}"
end
```

#### Using the post_search_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PostSearchResponseContent>, Integer, Hash)> post_search_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.post_search_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PostSearchResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->post_search_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **allow_no_indices** | **Boolean** |  | [optional] |
| **allow_partial_search_results** | **Boolean** |  | [optional] |
| **analyzer** | **String** |  | [optional] |
| **analyze_wildcard** | **Boolean** |  | [optional] |
| **batched_reduce_size** | **Integer** |  | [optional] |
| **ccs_minimize_roundtrips** | **Boolean** |  | [optional] |
| **default_operator** | [**DefaultOperator**](.md) |  | [optional] |
| **df** | **String** |  | [optional] |
| **docvalue_fields** | **String** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **explain** | **Boolean** |  | [optional] |
| **from** | **Integer** |  | [optional] |
| **ignore_throttled** | **Boolean** |  | [optional] |
| **ignore_unavailable** | **Boolean** |  | [optional] |
| **lenient** | **Boolean** |  | [optional] |
| **max_concurrent_shard_requests** | **Integer** |  | [optional] |
| **pre_filter_shard_size** | **Integer** |  | [optional] |
| **preference** | **String** |  | [optional] |
| **q** | **String** |  | [optional] |
| **request_cache** | **Boolean** |  | [optional] |
| **rest_total_hits_as_int** | **Boolean** |  | [optional] |
| **routing** | **String** |  | [optional] |
| **scroll** | **String** |  | [optional] |
| **search_type** | [**SearchType**](.md) |  | [optional] |
| **seq_no_primary_term** | **Boolean** |  | [optional] |
| **size** | **Integer** |  | [optional] |
| **sort** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **source** | **String** |  | [optional] |
| **source_excludes** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **source_includes** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **stats** | **String** |  | [optional] |
| **stored_fields** | **Boolean** |  | [optional] |
| **suggest_field** | **String** |  | [optional] |
| **suggest_mode** | [**SuggestMode**](.md) |  | [optional] |
| **suggest_size** | **Integer** |  | [optional] |
| **suggest_text** | **String** |  | [optional] |
| **terminate_after** | **Integer** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **track_scores** | **Boolean** |  | [optional] |
| **track_total_hits** | **Integer** |  | [optional] |
| **typed_keys** | **Boolean** |  | [optional] |
| **version** | **Boolean** |  | [optional] |
| **post_search_request_content** | [**PostSearchRequestContent**](PostSearchRequestContent.md) |  | [optional] |

### Return type

[**PostSearchResponseContent**](PostSearchResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## post_search_with_index

> <PostSearchWithIndexResponseContent> post_search_with_index(index, opts)



Returns results matching a query.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
opts = {
  allow_no_indices: true, # Boolean | 
  allow_partial_search_results: true, # Boolean | 
  analyzer: 'analyzer_example', # String | 
  analyze_wildcard: true, # Boolean | 
  batched_reduce_size: 56, # Integer | 
  ccs_minimize_roundtrips: true, # Boolean | 
  default_operator: OpenapiClient::DefaultOperator::AND, # DefaultOperator | 
  df: 'df_example', # String | 
  docvalue_fields: 'docvalue_fields_example', # String | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  explain: true, # Boolean | 
  from: 56, # Integer | 
  ignore_throttled: true, # Boolean | 
  ignore_unavailable: true, # Boolean | 
  lenient: true, # Boolean | 
  max_concurrent_shard_requests: 789, # Integer | 
  pre_filter_shard_size: 789, # Integer | 
  preference: 'preference_example', # String | 
  q: 'q_example', # String | 
  request_cache: true, # Boolean | 
  rest_total_hits_as_int: true, # Boolean | 
  routing: 'routing_example', # String | 
  scroll: '1d', # String | 
  search_type: OpenapiClient::SearchType::N0, # SearchType | 
  seq_no_primary_term: true, # Boolean | 
  size: 56, # Integer | 
  sort: ['inner_example'], # Array<String> | 
  source: 'source_example', # String | 
  source_excludes: ['inner_example'], # Array<String> | 
  source_includes: ['inner_example'], # Array<String> | 
  stats: 'stats_example', # String | 
  stored_fields: true, # Boolean | 
  suggest_field: 'suggest_field_example', # String | 
  suggest_mode: OpenapiClient::SuggestMode::N0, # SuggestMode | 
  suggest_size: 789, # Integer | 
  suggest_text: 'suggest_text_example', # String | 
  terminate_after: 56, # Integer | 
  timeout: 'timeout_example', # String | 
  track_scores: true, # Boolean | 
  track_total_hits: 56, # Integer | 
  typed_keys: true, # Boolean | 
  version: true, # Boolean | 
  post_search_with_index_request_content: OpenapiClient::PostSearchWithIndexRequestContent.new # PostSearchWithIndexRequestContent | 
}

begin
  
  result = api_instance.post_search_with_index(index, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->post_search_with_index: #{e}"
end
```

#### Using the post_search_with_index_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PostSearchWithIndexResponseContent>, Integer, Hash)> post_search_with_index_with_http_info(index, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.post_search_with_index_with_http_info(index, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PostSearchWithIndexResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->post_search_with_index_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **allow_no_indices** | **Boolean** |  | [optional] |
| **allow_partial_search_results** | **Boolean** |  | [optional] |
| **analyzer** | **String** |  | [optional] |
| **analyze_wildcard** | **Boolean** |  | [optional] |
| **batched_reduce_size** | **Integer** |  | [optional] |
| **ccs_minimize_roundtrips** | **Boolean** |  | [optional] |
| **default_operator** | [**DefaultOperator**](.md) |  | [optional] |
| **df** | **String** |  | [optional] |
| **docvalue_fields** | **String** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **explain** | **Boolean** |  | [optional] |
| **from** | **Integer** |  | [optional] |
| **ignore_throttled** | **Boolean** |  | [optional] |
| **ignore_unavailable** | **Boolean** |  | [optional] |
| **lenient** | **Boolean** |  | [optional] |
| **max_concurrent_shard_requests** | **Integer** |  | [optional] |
| **pre_filter_shard_size** | **Integer** |  | [optional] |
| **preference** | **String** |  | [optional] |
| **q** | **String** |  | [optional] |
| **request_cache** | **Boolean** |  | [optional] |
| **rest_total_hits_as_int** | **Boolean** |  | [optional] |
| **routing** | **String** |  | [optional] |
| **scroll** | **String** |  | [optional] |
| **search_type** | [**SearchType**](.md) |  | [optional] |
| **seq_no_primary_term** | **Boolean** |  | [optional] |
| **size** | **Integer** |  | [optional] |
| **sort** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **source** | **String** |  | [optional] |
| **source_excludes** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **source_includes** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **stats** | **String** |  | [optional] |
| **stored_fields** | **Boolean** |  | [optional] |
| **suggest_field** | **String** |  | [optional] |
| **suggest_mode** | [**SuggestMode**](.md) |  | [optional] |
| **suggest_size** | **Integer** |  | [optional] |
| **suggest_text** | **String** |  | [optional] |
| **terminate_after** | **Integer** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **track_scores** | **Boolean** |  | [optional] |
| **track_total_hits** | **Integer** |  | [optional] |
| **typed_keys** | **Boolean** |  | [optional] |
| **version** | **Boolean** |  | [optional] |
| **post_search_with_index_request_content** | [**PostSearchWithIndexRequestContent**](PostSearchWithIndexRequestContent.md) |  | [optional] |

### Return type

[**PostSearchWithIndexResponseContent**](PostSearchWithIndexResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## put_create_index

> <PutCreateIndexResponseContent> put_create_index(index, opts)



Creates index mappings.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  include_type_name: true, # Boolean | 
  wait_for_active_shards: 'wait_for_active_shards_example', # String | 
  timeout: 'timeout_example', # String | 
  put_create_index_request_content: OpenapiClient::PutCreateIndexRequestContent.new # PutCreateIndexRequestContent | 
}

begin
  
  result = api_instance.put_create_index(index, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->put_create_index: #{e}"
end
```

#### Using the put_create_index_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PutCreateIndexResponseContent>, Integer, Hash)> put_create_index_with_http_info(index, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.put_create_index_with_http_info(index, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PutCreateIndexResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->put_create_index_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **include_type_name** | **Boolean** |  | [optional] |
| **wait_for_active_shards** | **String** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **put_create_index_request_content** | [**PutCreateIndexRequestContent**](PutCreateIndexRequestContent.md) |  | [optional] |

### Return type

[**PutCreateIndexResponseContent**](PutCreateIndexResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## put_index_mapping_with_index

> <PutIndexMappingWithIndexResponseContent> put_index_mapping_with_index(index, opts)



The put mapping API operation lets you add new mappings and fields to an index.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
index = 'books' # String | 
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  allow_no_indices: true, # Boolean | 
  expand_wildcards: OpenapiClient::ExpandWildcards::ALL, # ExpandWildcards | 
  ignore_unavailable: true, # Boolean | 
  include_type_name: true, # Boolean | 
  timeout: 'timeout_example', # String | 
  write_index_only: true, # Boolean | 
  put_index_mapping_with_index_request_content: OpenapiClient::PutIndexMappingWithIndexRequestContent.new # PutIndexMappingWithIndexRequestContent | 
}

begin
  
  result = api_instance.put_index_mapping_with_index(index, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->put_index_mapping_with_index: #{e}"
end
```

#### Using the put_index_mapping_with_index_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PutIndexMappingWithIndexResponseContent>, Integer, Hash)> put_index_mapping_with_index_with_http_info(index, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.put_index_mapping_with_index_with_http_info(index, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PutIndexMappingWithIndexResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->put_index_mapping_with_index_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **String** |  |  |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **allow_no_indices** | **Boolean** |  | [optional] |
| **expand_wildcards** | [**ExpandWildcards**](.md) |  | [optional] |
| **ignore_unavailable** | **Boolean** |  | [optional] |
| **include_type_name** | **Boolean** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **write_index_only** | **Boolean** |  | [optional] |
| **put_index_mapping_with_index_request_content** | [**PutIndexMappingWithIndexRequestContent**](PutIndexMappingWithIndexRequestContent.md) |  | [optional] |

### Return type

[**PutIndexMappingWithIndexResponseContent**](PutIndexMappingWithIndexResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## put_update_cluster_settings

> <PutUpdateClusterSettingsResponseContent> put_update_cluster_settings(opts)



Updates the cluster settings.

### Examples

```ruby
require 'time'
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: smithy.api.httpBasicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = OpenapiClient::DefaultApi.new
opts = {
  master_timeout: 'master_timeout_example', # String | 
  cluster_manager_timeout: 'cluster_manager_timeout_example', # String | 
  flat_settings: true, # Boolean | 
  timeout: 'timeout_example', # String | 
  put_update_cluster_settings_request_content: OpenapiClient::PutUpdateClusterSettingsRequestContent.new # PutUpdateClusterSettingsRequestContent | 
}

begin
  
  result = api_instance.put_update_cluster_settings(opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->put_update_cluster_settings: #{e}"
end
```

#### Using the put_update_cluster_settings_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PutUpdateClusterSettingsResponseContent>, Integer, Hash)> put_update_cluster_settings_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.put_update_cluster_settings_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PutUpdateClusterSettingsResponseContent>
rescue OpenapiClient::ApiError => e
  puts "Error when calling DefaultApi->put_update_cluster_settings_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **master_timeout** | **String** |  | [optional] |
| **cluster_manager_timeout** | **String** |  | [optional] |
| **flat_settings** | **Boolean** |  | [optional] |
| **timeout** | **String** |  | [optional] |
| **put_update_cluster_settings_request_content** | [**PutUpdateClusterSettingsRequestContent**](PutUpdateClusterSettingsRequestContent.md) |  | [optional] |

### Return type

[**PutUpdateClusterSettingsResponseContent**](PutUpdateClusterSettingsResponseContent.md)

### Authorization

[smithy.api.httpBasicAuth](../README.md#smithy.api.httpBasicAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

