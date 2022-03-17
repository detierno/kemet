# frozen_string_literal: true

module Kemet
  class Stack # :nodoc:
    def initialize
      @events = []
    end

    def add(event)
      @events.push(event)
    end

    def any?
      @events.any?
    end

    def pop!
      @events.pop
    end
  end
end
