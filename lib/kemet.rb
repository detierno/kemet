# frozen_string_literal: true

require "logger"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Kemet
  class Error < StandardError; end
  class AlreadyChosenColorError < StandardError; end
  class ActionInProgressError < StandardError; end
end
