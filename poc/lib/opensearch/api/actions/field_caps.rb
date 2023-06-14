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
      FIELD_CAPS_QUERY_PARAMS = Set.new(%i[
        fields
        ignore_unavailable
        allow_no_indices
        expand_wildcards
        include_unmapped
      ]).freeze
    
      # Returns the information about the capabilities of fields among multiple indices.
      #
      # @option arguments [Array] :fields Comma-separated list of field names.
      # @option arguments [Boolean] :ignore_unavailable Whether specified concrete indices should be ignored when unavailable (missing or closed).
      # @option arguments [Boolean] :allow_no_indices Whether to ignore if a wildcard indices expression resolves into no concrete indices. (This includes `_all` string or when no indices have been specified).
      # @option arguments [String] :expand_wildcards Whether to expand wildcard expression to concrete indices that are open, closed or both.
      # @option arguments [Boolean] :include_unmapped Indicates whether unmapped fields should be included in the response.
      # @option arguments [Array] :index Comma-separated list of indices; use `_all` or empty string to perform the operation on all indices.
      # @option arguments [Hash] :body 
      def field_caps(arguments = {})
        arguments = arguments.clone
        _index = Utils.__listify(arguments.delete(:index))
    
        headers = arguments.delete(:headers) || {}
        body    = arguments.delete(:body)
        url     = Utils.__pathify _index, '_field_caps'
        method  = body ? OpenSearch::API::HTTP_POST : OpenSearch::API::HTTP_GET
        params  = Utils.__validate_and_extract_params arguments, FIELD_CAPS_QUERY_PARAMS
    
        params[:fields] = Utils.__listify(params[:fields]) if params[:fields]
    
        perform_request(method, url, params, body, headers).body
      end
    end
  end
end
