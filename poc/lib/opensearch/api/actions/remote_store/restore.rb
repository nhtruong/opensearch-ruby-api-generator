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
    module RemoteStore
      module Actions
        RESTORE_PARAMS = Set.new(%i[
          cluster_manager_timeout
          wait_for_completion
        ]).freeze
      
        # Restore one or more indices from a remote backup.
        #
        # @option arguments [String] :cluster_manager_timeout - 
        # @option arguments [Boolean] :wait_for_completion - 
        # @option arguments [Hash] :body - * Required * 
        def restore(arguments = {})
          raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]
      
          arguments = arguments.clone
      
          headers = arguments.delete(:headers) || {}
          body    = arguments.delete(:body)
          params  = Utils.__validate_and_extract_params arguments, RESTORE_PARAMS
          url     = Utils.__pathify '_remotestore', '_restore'
          method  = OpenSearch::API::HTTP_POST
      
      
          perform_request(method, url, params, body, headers).body
        end
      end
    end
  end
end
