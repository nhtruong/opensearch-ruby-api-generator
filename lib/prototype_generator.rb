# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'signature_generator'

# Generate a Prototype file via Mustache
class PrototypeGenerator < BaseGenerator
  self.template_file = './templates/prototype.mustache'

  # @param [Pathname] output_folder Output folder
  # @param [String] namespace Namespace name
  # @param [Array<Action>] actions Actions in the namespace
  def initialize(output_folder, namespace, actions)
    super(output_folder)
    @namespace = namespace
    @camelized_namespace = @namespace.camelcase
    @actions = actions
  end

  def signatures
    @actions.sort_by(&:name).map do |action|
      SignatureGenerator.new(@output_folder, action).render
    end.join
  end
end
