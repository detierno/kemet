# frozen_string_literal: true

require "test_helper"

module Kemet
  class MatchTest < Minitest::Test
    def setup
      @match = Kemet::Match.new(listener: Proc.new {})
    end

    def test_add_player
      @match.add_player(:red)

      refute_empty @match.players
    end

    def test_add_player_of_same_color
      @match.add_player(:red)

      assert_raises(AlreadyChosenColorError) { @match.add_player(:red) }
    end

    def test_setup_generate_di_deck
      @match.add_player(:red)
      @match.add_player(:blue)
      @match.setup!

      # assert_equal 35, @match.di_deck.size # real size
      assert_equal 6, @match.di_deck.size
    end
  end
end
