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

# Generate a Namespace file via Mustache
class NamespaceGenerator < BaseGenerator
  self.template_file = './templates/namespace.mustache'

  attr_reader :namespace

  def initialize(namespace)
    @namespace = namespace
    super
  end

  def module_name
    namespace.camelize
  end

  def client_name
    "#{namespace.camelize}Client"
  end
end
