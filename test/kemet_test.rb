# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Kemet do
    describe "a 2 player full match" do
      it "works" do
        @events = []
        @listener = proc { |event| @events << event }

        match = Match.new(listener: @listener)
        black_player = match.add_player(:black)
        green_player = match.add_player(:green)

        match.start!

        d1, d2 = match.current_action_properties[:targets]

        green_player.add_pyramid(Pyramids::Ruby.new(1), target: d1)
        green_player.add_pyramid(Pyramids::Diamond.new(2), target: d2)

        district = match.current_action_properties[:targets].first
        black_player.add_pyramid(Pyramids::Ruby.new(3), target: district)

        events = @events.map { |e| e[:event] }
        assert_equal expected_events, events
      end

      def expected_events
        [
          "stack_added: AddPyramid",
          "stack_added: AddPyramid",
          "event: Match setup completed",
          "current_action_changed: AddPyramid",
          "action_performed: AddPyramid",
          "action_performed: AddPyramid",
          "current_action_changed: AddPyramid",
          "action_performed: AddPyramid"
        ]
      end
    end
  end
end
