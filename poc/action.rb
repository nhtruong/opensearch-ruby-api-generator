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
    module Cat
      module Actions
        INDICES_PARAMS = Set.new(%i[
          master_timeout
          cluster_manager_timeout
          bytes
          expand_wildcards
          health
          include_unloaded_segments
          pri
          time
          format
        ]).freeze
      
        # Returns information about indices: number of primaries and replicas, document counts, disk size, etc.
        #
        # @option arguments [String] :index - * Required * 
        # @option arguments [String] :master_timeout - DEPRECATED 
        # @option arguments [String] :cluster_manager_timeout - 
        # @option arguments [Integer] :bytes - 
        # @option arguments [String] :expand_wildcards - 
        # @option arguments [String] :health - 
        # @option arguments [Boolean] :include_unloaded_segments - 
        # @option arguments [Boolean] :pri - 
        # @option arguments [String] :time - 
        # @option arguments [String] :format - 
        def indices(arguments = {})
          raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]
      
          arguments = arguments.clone
      
          _index = Utils.__listify(arguments.delete(:index))
      
          headers = arguments.delete(:headers) || {}
          body    = arguments.delete(:body)
          params  = Utils.__validate_and_extract_params arguments, INDICES_PARAMS
          path    = Utils.__pathify '_cat', 'indices', _index
          method  = OpenSearch::API::HTTP_GET
      
      
          perform_request(method, path, params, body, headers).body
        end
      end
    end
  end
end
