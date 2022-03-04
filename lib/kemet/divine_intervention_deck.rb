# frozen_string_literal: true

require "psych"

module Kemet
  class DivineInterventionDeck # :nodoc:
    def self.cards
      card_list.each_with_object([]) do |card, ary|
        card["quantity"].times { ary << Object.const_get("Kemet::DivineInterventions::#{card["name"]}").new }
      end
    end

    def self.card_list
      Psych.safe_load(File.open(File.expand_path("lib/kemet/templates/divine_intervention.yml")))
    end
  end
end
