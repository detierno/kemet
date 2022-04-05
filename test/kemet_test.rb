# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Kemet do
    describe "a 2 player full match" do
      it "works" do
        @events = []
        @listener = proc { |e| @events << "#{e[:type]}: #{e[:event]}" }

        match = Match.new(listener: @listener)
        black_player = match.add_player(:black)
        green_player = match.add_player(:green)

        match.players.expects(:shuffle!).returns([black_player, green_player])

        match.start!

        district = match.current_action_properties[:targets].first
        black_player.add_pyramid(Pyramids::Ruby.new(3), target: district)

        properties = match.current_action_properties

        black_player
          .place_troop(size: properties[:troop_size], target: properties[:targets].first)

        black_player
          .place_troop(size: properties[:troop_size], target: properties[:targets].last)

        d1, d2 = match.current_action_properties[:targets]

        green_player.add_pyramid(Pyramids::Ruby.new(1), target: d1)
        green_player.add_pyramid(Pyramids::Diamond.new(2), target: d2)

        properties = match.current_action_properties

        green_player
          .place_troop(size: properties[:troop_size], target: properties[:targets].first)

        green_player
          .place_troop(size: properties[:troop_size], target: properties[:targets].last)

        # black_player.available_actions #=> [<PlaceTroop: targets: [:d2, :d3, :d1]>, BuyPower, ...]

        assert_equal expected_events, @events
      end

      # rubocop:disable Metrics/MethodLength
      def expected_events # :nodoc:
        [
          "stack_added: AddPyramid - Player: black - targets: d2, d3, d1",
          "stack_added: PlaceTroop - Player: black - targets: d2, d3, d1 - troop_size: 5",
          "stack_added: PlaceTroop - Player: black - targets: d2, d3, d1 - troop_size: 5",
          "event: DI card received - Player: black - quantity: 2",
          "stack_added: AddPyramid - Player: green - targets: d5, d6, d4",
          "stack_added: PlaceTroop - Player: green - targets: d5, d6, d4 - troop_size: 5",
          "stack_added: PlaceTroop - Player: green - targets: d5, d6, d4 - troop_size: 5",
          "event: DI card received - Player: green - quantity: 2",
          "event: Match setup completed",
          "current_action_changed: AddPyramid - Player: black - targets: d2, d3, d1",
          "stack_added: PlayerAction - Player: black",
          "event: New game round",
          "action_performed: AddPyramid - Player: black - targets: d2, d3, d1",
          "current_action_changed: PlaceTroop - Player: black - targets: d2, d3, d1 - troop_size: 5",
          "action_performed: PlaceTroop - Player: black - targets: d2, d3, d1 - troop_size: 5",
          "current_action_changed: PlaceTroop - Player: black - targets: d2, d3, d1 - troop_size: 5",
          "action_performed: PlaceTroop - Player: black - targets: d2, d3, d1 - troop_size: 5",
          "current_action_changed: AddPyramid - Player: green - targets: d5, d6, d4",
          "action_performed: AddPyramid - Player: green - targets: d5, d6, d4",
          "action_performed: AddPyramid - Player: green - targets: d5, d6, d4",
          "current_action_changed: PlaceTroop - Player: green - targets: d5, d6, d4 - troop_size: 5",
          "action_performed: PlaceTroop - Player: green - targets: d5, d6, d4 - troop_size: 5",
          "current_action_changed: PlaceTroop - Player: green - targets: d5, d6, d4 - troop_size: 5",
          "action_performed: PlaceTroop - Player: green - targets: d5, d6, d4 - troop_size: 5",
          "current_action_changed: PlayerAction - Player: black"
        ]
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
