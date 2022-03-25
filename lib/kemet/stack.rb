# frozen_string_literal: true

module Kemet
  class Stack # :nodoc:
    def initialize
      @queue = []
    end

    def add(event)
      @queue.push(event)
    end

    def any?
      @queue.any?
    end

    def pop!
      @queue.shift
    end
  end
end
