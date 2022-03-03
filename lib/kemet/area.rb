# frozen_string_literal: true

module Kemet
  class Area
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def link_areas(*areas)
      connections.push(areas).flatten!
    end

    def connections
      @connections ||= []
    end

    def walled?
      false
    end

    def temple?
      false
    end

    def obelysk?
      false
    end

    def sanctuary?
      false
    end

    def allow_piramid?
      false
    end
  end
end
