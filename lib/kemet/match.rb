# frozen_string_literal: true

module Kemet
  # Wrapper to generate a match of Kemet board game
  class Match
    attr_reader :board, :current_action, :current_round, :di_deck, :turn_order, :players, :power_tile_deck, :stack

    def initialize(listener: std_listener)
      @listener = listener
      @events = []
      @current_action = nil
      @current_round_count = 0
      @players = []
      @stack = Stack.new
      @di_deck = Decks::DivineIntervention.new
      @power_tile_deck = Decks::PowerTile.new
    end

    # Interface for events and actions
    # for adding new entries to match stack
    #
    # @param action [Event,Action]
    #
    def add_to_stack(action)
      stack.add(action)
      notify!(:stack_added, action)
    end

    # Add a player to current match
    #
    # @param color <Symbol> a color to identify a player
    # @return [Player]
    #
    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      Player.new(color, self).tap { |player| players << player }
    end

    # Return current action properties hash. This
    # hash can be used by the listener to drive player actions
    #
    # @return [Hash<Symbol=>Any]
    #
    def current_action_properties
      current_action.properties
    end

    # Draw card from divine intervention deck
    #
    # @return DivineIntervention::Card
    #
    def draw_di_card
      di_deck.draw
    end

    # Trigger an event unrelated to stack or player
    # interaction
    #
    # @param event <Event>
    #
    def event(event)
      event.call
      notify!(:event, event)
    end

    # Access point for players interaction with
    # current action, like player.add_pyramid({}). This
    # allows players to be unaware of current action at all.
    #
    # After an interaction take place this method will
    # try to move to next action in stack.
    #
    def interaction(player, opts = {})
      @current_action.interact(self, player, opts)
      notify!(:action_performed, @current_action)
      next_action!
    end

    # Initiate a match, setting player areas
    # and initializing first round
    #
    def start!
      setup!
      next_round
    end

    private
      attr_reader :listener

      def next_action!
        return if @current_action && !@current_action.satisfied?

        @current_action = stack.pop!
        notify!(:current_action_changed, @current_action) if @current_action
      end

      def next_round
        @current_round_count += 1
        event = Events::NewRound.new(self)
        notify!(:event, event)
        @current_round = event.round
      end

      def notify!(type, *events)
        events.each do |event|
          msg = { type: type, event: event.to_event, properties: event.properties }

          track_event(msg)
          listener.call(msg)
        end
      end

      def setup!
        @board = Board.new(players)
        @turn_order = players.shuffle!

        notify!(:event, Events::MatchSetupCompleted.new(self))
        next_action!
      end

      def std_listener
        Logger.new($stdout).tap do |listener|
          listener.define_singleton_method(:call) { |msg| debug(msg) }
          listener.formatter = ->(_, _, _, msg) { "#{msg}\n" }
        end
      end

      def track_event(event)
        @events << event
      end
  end
end
