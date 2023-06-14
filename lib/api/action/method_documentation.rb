# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

module Api
  module Action
    # Logic to generate Method Documentation for each Action
    module MethodDocumentation
      def method_description
        @operations.first.description
      end

      def argument_descriptions
        params_desc + [body_desc].compact
      end

      private

      def params_desc
        parameters.map do |p|
          {
            data_type: p.ruby_type,
            name: p.name,
            required: p.name.in?(_required),
            description: p.description,
            default: p.default,
            deprecated: p.deprecated?,
          }
        end
      end

      def body_desc
        body = @operations.map(&:request_body).find(&:present?)
        return if body.nil?

        { data_type: :Hash,
          name: :body,
          required: 'body'.in?(_required),
          description: body.description }
      end
    end
  end
end

