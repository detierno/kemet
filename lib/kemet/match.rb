# frozen_string_literal: true

module Kemet
  # Wrapper to generate a match of Kemet board game
  class Match
    attr_reader :board, :current_action, :current_turn, :di_deck, :turn_order, :players, :power_tile_deck, :stack

    def initialize(listener: std_listener)
      @listener = listener
      @events = []
      @current_action = nil
      @players = []
      @stack = Stack.new
      @di_deck = Decks::DivineIntervention.new
      @power_tile_deck = Decks::PowerTile.new
    end

    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      Player.new(color, self).tap { |player| players << player }
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
      next_action!
    end

    private
      attr_reader :listener

      def next_action!
        raise(ActionInProgressError) if current_action

        @current_action = stack.pop!
      end

      def notify!(*events)
        events.each do |event|
          track_event(event)
          listener.call "Event: #{event.inspect}"
        end
      end

      def track_event(event)
        @events << event
      end

      def std_listener
        Logger.new($stdout).tap do |listener|
          listener.define_singleton_method(:call) { |msg| debug(msg) }
          listener.formatter = ->(_, _, _, msg) { "#{msg}\n" }
        end
      end
  end
end
