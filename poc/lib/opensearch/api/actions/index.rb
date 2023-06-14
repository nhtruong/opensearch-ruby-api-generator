# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# This code was generated from OpenSearch API Spec.
# Update the code generation logic instead of modifying this file directly.

# frozen_string_literal: true

module OpenSearch
  module API
    module Actions
      INDEX_QUERY_PARAMS = Set.new(%i[
        wait_for_active_shards
        op_type
        refresh
        routing
        timeout
        version
        version_type
        if_seq_no
        if_primary_term
        pipeline
        require_alias
      ]).freeze
    
      # Creates or updates a document in an index.
      #
      # @option arguments [String] :index *Required* Index name.
      # @option arguments [String] :wait_for_active_shards (default: 1) Sets the number of shard copies that must be active before proceeding with the operation. Defaults to 1, meaning the primary shard only. Set to `all` for all shard copies, otherwise set to any non-negative value less than or equal to the total number of copies for the shard (number of replicas + 1).
      # @option arguments [String] :op_type Explicit operation type. Defaults to `index` for requests with an explicit document ID, and to `create`for requests without an explicit document ID.
      # @option arguments [String] :refresh If `true` then refresh the affected shards to make this operation visible to search, if `wait_for` then wait for a refresh to make this operation visible to search, if `false` (the default) then do nothing with refreshes.
      # @option arguments [String] :routing Routing value.
      # @option arguments [Time] :timeout Operation timeout.
      # @option arguments [Integer] :version Explicit version number for concurrency control.
      # @option arguments [String] :version_type Specific version type.
      # @option arguments [Integer] :if_seq_no only perform the operation if the last operation that has changed the document has the specified sequence number.
      # @option arguments [Integer] :if_primary_term only perform the operation if the last operation that has changed the document has the specified primary term.
      # @option arguments [String] :pipeline The pipeline id to preprocess incoming documents with.
      # @option arguments [Boolean] :require_alias When true, requires destination to be an alias.
      # @option arguments [String] :id Document ID.
      # @option arguments [Hash] :body *Required* 
      def index(arguments = {})
        raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]
        raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
    
        arguments = arguments.clone
        _index = arguments.delete(:index)
        _id = arguments.delete(:id)
    
        headers = arguments.delete(:headers) || {}
        body    = arguments.delete(:body)
        url     = Utils.__pathify _index, '_doc', _id
        method  = _id ? OpenSearch::API::HTTP_PUT : OpenSearch::API::HTTP_POST
        params  = Utils.__validate_and_extract_params arguments, INDEX_QUERY_PARAMS
    
        perform_request(method, url, params, body, headers).body
      end
    end
  end
end
