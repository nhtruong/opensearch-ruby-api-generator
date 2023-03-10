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
      module Actions; end

      # Client for the "remote_store" namespace (includes the RemoteStore::Actions methods)
      class RemoteStoreClient
        include Common::Client, Common::Client::Base, RemoteStore::Actions
      end

      # Proxy method for RemoteStoreClient, available in the receiving object
      def remote_store
        @remote_store ||= RemoteStoreClient.new(self)
      end
    end
  end
end
