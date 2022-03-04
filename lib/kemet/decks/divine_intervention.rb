# frozen_string_literal: true

require "psych"

module Kemet
  module Decks
    class DivineIntervention # :nodoc:
      extend Forwardable

      attr_reader :cards

      def_delegator :cards, :size, :size

      def initialize
        @cards = load_cards
      end

      def load_cards
        card_list.each_with_object([]) do |card, ary|
          card["quantity"].times { ary << Object.const_get("Kemet::DivineInterventions::#{card["name"]}").new }
        end
      end

      private
        def card_list
          Psych.safe_load(File.open(File.expand_path("lib/kemet/templates/divine_intervention.yml")))
        end
    end
  end
end
