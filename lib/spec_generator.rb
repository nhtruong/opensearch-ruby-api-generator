# SPDX-License-Identifier: Apache-2.0
#
# The OpenSearch Contributors require contributions made to
# this file be licensed under the Apache-2.0 license or a
# compatible open source license.
#
# Modifications Copyright OpenSearch Contributors. See
# GitHub history for details.

# frozen_string_literal: true

require_relative 'base_generator'
require_relative 'action'

# Generate Spec test for an API Action via Mustache
class SpecGenerator < BaseGenerator
  self.template_file = './templates/spec.mustache'
  attr_reader :action, :http_verb
  delegate :namespace, :name, to: :action

  # @param [Pathname] output_folder
  # @param [Action] action
  def initialize(output_folder, action)
    super(output_folder)
    @action = action
    @http_verb = action.http_verbs.sort.first.upcase
  end

  private

  def output_file
    create_folder(*[@output_folder, @action.namespace].compact).join("#{@action.name}_spec.rb")
  end
end
