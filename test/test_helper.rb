# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "kemet"

require "minitest/autorun"
require 'color_pound_spec_reporter'

require 'minitest/unit'
require 'mocha/minitest'

Minitest::Reporters.use! [ColorPoundSpecReporter.new]
