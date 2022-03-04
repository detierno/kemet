# frozen_string_literal: true

require "psych"

module Kemet
  class DivineInterventionDeck
    def self.cards
      card_list.inject([]) do |ary, card|
        card['quantity'].times { ary << Object.const_get("Kemet::DivineInterventions::#{card['name']}").new }
        ary
      end
    end

    def self.card_list
      Psych.safe_load(File.open(File.expand_path("lib/kemet/templates/divine_intervention.yml")))
    end
  end
end
