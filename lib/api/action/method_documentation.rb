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
        url_args_desc + [body_arg_desc].compact
      end

      private

      def url_args_desc
        @operations.map(&:parameters).map(&:to_a).flatten.index_by(&:name).values.map do |p|
          {
            data_type: p.schema.type.capitalize,
            name: p.name,
            required: p.name.in?(_required),
            deprecated: p.schema.deprecated?,
            default: p.schema.default,
            description: p.description
          }
        end
      end

      def body_arg_desc
        body = @operations.map(&:request_body).find(&:present?)
        return nil if body.nil?

        { data_type: :Hash,
           name: :body,
           required: 'body'.in?(_required),
           description: body.description }
      end
    end
  end
end

