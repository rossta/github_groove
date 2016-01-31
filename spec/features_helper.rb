# Require this file for feature tests
require_relative "./spec_helper"

require "capybara"
require "capybara/dsl"

Capybara.app = Hanami::Container.new

module MiniTest
  class Spec
    include Capybara::DSL
  end
end
