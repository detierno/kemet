# frozen_string_literal: true

require_relative "kemet/version"
require_relative "kemet/match"
require_relative "kemet/player"
require_relative "kemet/board"
require_relative "kemet/area"
require_relative "kemet/areas/desert"
require_relative "kemet/areas/district"
require_relative "kemet/areas/sanctuary"

module Kemet
  class Error < StandardError; end
  class AlreadyChosenColorError < StandardError; end
end
