# frozen_string_literal: true

module Kemet
  # Wrapper to generate a match of Kemet board game
  class Match
    attr_reader :board, :current_turn, :di_deck, :turn_order, :players, :power_tile_deck, :stack

    def initialize(logger: std_logger)
      @logger = logger
      @events = []
      @current_action = nil
      @players = []
      @stack = Stack.new
      @di_deck = Decks::DivineIntervention.new
      @power_tile_deck = Decks::PowerTile.new
    end

    # Probably this is useless and conflicts with
    # waiting_action? method
    def action_in_progress?
      !!@current_action
    end

    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      Player.new(color, self).tap { |player| players << player }
    end

    # Interface to what players should do
    #
    # @return <String>
    #
    attr_reader :current_action

    def next_action!
      raise(ActionInProgressError) if current_action

      @current_action = stack.pop!
    end

    def start!
      @current_turn = Turn.new(match: self)
    end

    def interaction(player, opts = {})
      @current_action.interact(self, player, opts)
    end

    def setup!
      @board = Board.new(players)
      @turn_order = players.shuffle!

      notify!(Events::MatchSetupCompleted.new(self))
    end

    def waiting_action?
      stack.any?
    end

    private
      attr_reader :logger

      def notify!(*events)
        events.each do |event|
          track_event(event)
          logger.debug "Event: #{event.inspect}"
          players.each { |player| player.receive_event(event) }
        end
      end

      def track_event(event)
        @events << event
      end

      def std_logger
        Logger.new($stdout).tap do |logger|
          logger.formatter = ->(_, _, _, msg) { "#{msg}\n" }
        end
      end
  end
end
