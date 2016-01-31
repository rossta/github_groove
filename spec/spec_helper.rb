# Require this file for unit tests
ENV["HANAMI_ENV"] ||= "test"

require_relative "../config/environment"
require "minitest/autorun"
require "minitest/pride" # awesome colorful output
require "pry"

Hanami::Application.preload!
