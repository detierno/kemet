# frozen_string_literal: true

require "test_helper"

module Kemet
  class MatchTest < Minitest::Test
    def setup
      @match = Kemet::Match.new
    end

    def test_add_player
      @match.add_player(:red)

      refute_empty @match.players
    end

    def test_add_player_of_same_color
      @match.add_player(:red)

      assert_raises(AlreadyChosenColorError) { @match.add_player(:red) }
    end
  end
end
