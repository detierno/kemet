# frozen_string_literal: true

require "psych"
require "set"

module Kemet
  # Generate board instances for a match based on map templates
  class Board
    attr_reader :players

    def initialize(players)
      @players = players
      setup
    end

    def areas
      @areas ||= Set.new
    end

    def inspect
      "Board"
    end

    private
      def build_area(entry)
        case entry["type"]
        when "sanctuary"
          Areas::Sanctuary.new(entry["id"].to_sym, prayer_points: entry["prayer_points"])
        when "district"
          Areas::District.new(entry["id"].to_sym)
        when "desert"
          Areas::Desert.new(entry["id"].to_sym, obelysk: entry["obelysk"])
        end
      end

      def link_board
        template.each do |entry|
          area = areas.find { |a| a.id.to_s == entry["id"] }
          targets = areas.select { |a| entry["links"].include?(a.id.to_s) }

          area.link_areas(*targets)
        end
      end

      def setup
        setup_areas
        link_board
        set_cities
      end

      def setup_areas
        template.each do |entry|
          area = build_area(entry)
          areas.add(area)
        end
      end

      def set_cities
        players.each do |player|
          areas = city_areas(player)
          player.city = Areas::City.new(player, areas)
        end
      end

      def city_areas(player)
        first_available = areas.detect { |a| a.is_a?(Areas::District) && a.owner.nil? }
        districts = first_available.connections.select { |a| a.is_a?(Areas::District) } << first_available
        districts.each { |district| district.owner = player }
      end

      def template
        @template ||= Psych.safe_load(File.open(File.expand_path("lib/kemet/templates/boards/#{template_file}.yml")))
      end

      def template_file
        case players.count
        when 2 then "two_players"
        end
      end
  end
end
