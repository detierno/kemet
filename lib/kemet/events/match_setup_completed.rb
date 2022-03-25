# frozen_string_literal: true

module Kemet
  module Events
    class MatchSetupCompleted # :nodoc:
      def initialize(match)
        match.players.each { |player| match.add_to_stack(Actions::AddPyramid.new(player)) }
      end

      def name
        "Match setup completed"
      end

      def to_event
        { name: name }
      end
    end
  end
end
