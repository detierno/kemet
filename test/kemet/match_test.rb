# frozen_string_literal: true

require "test_helper"

module Kemet
  class MatchTest < Minitest::Test
    def setup
      @match = Kemet::Match.new(logger: Logger.new(nil))
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

    class NextActionTest < Minitest::Test
      def setup
        stack = %w[Action1 Action2]
        stack.define_singleton_method(:pop!) { pop }

        @match = Kemet::Match.new(logger: Logger.new(nil))
        @match.instance_variable_set(:"@stack", stack)
      end

      def test_dont_pull_new_action_over_open_one
        assert_nil @match.current_action
        @match.next_action!
        assert_equal "Action2", @match.current_action

        assert_raises(ActionInProgressError) { @match.next_action! }
      end
    end
  end
end
