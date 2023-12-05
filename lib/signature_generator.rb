# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'action'

# Generate the API Method Signature via Mustache
class SignatureGenerator < BaseGenerator
  self.template_file = './templates/signature.mustache'
  attr_reader :function_name

  # @param [Pathname] output_folder
  # @param [Action] action
  def initialize(output_folder, action)
    super(output_folder)
    @action = action
    @function_name = action.name.camelcase(:lower)
  end

  def optional
    @action.required_params.empty?
  end
end
