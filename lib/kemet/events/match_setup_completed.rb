# frozen_string_literal: true

module Kemet
  module Events
    class MatchSetupCompleted # :nodoc:
      def initialize(match)
        match.players.each { |player| match.stack.add(Actions::AddPyramid.new(player)) }
      end
    end
  end
end
