# frozen_string_literal: true

module Kemet
  module Events
    class MatchSetupCompleted # :nodoc:
      def initialize(match)
        match.players.each { |player| match.add_to_stack(Actions::AddPyramid.new(player)) }
      end

      def to_event
        { type: :event, name: self.class.to_s }
      end
    end
  end
end
