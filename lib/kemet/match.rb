# frozen_string_literal: true

module Kemet
  # Wrapper to generate a match of Kemet board game
  class Match
    attr_reader :current_turn, :di_deck, :turn_order, :power_tile_deck

    def initialize
      @logger = Logger.new($stdout)
      @logger.formatter = ->(_, _, _, msg) { "#{msg}\n" }
      @events = []
    end

    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      players << Player.new(color)
    end

    def start!
      @current_turn = Turn.new(match: self)
    end

    def setup!
      @di_deck = Decks::DivineIntervention.new
      @power_tile_deck = Decks::PowerTile.new
      @turn_order = players.shuffle!

      notify!(Events::MatchSetupCompleted.new)
    end

    def players
      @players ||= []
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
  end
end
