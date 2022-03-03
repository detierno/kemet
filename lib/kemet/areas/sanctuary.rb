# frozen_string_literal: true

module Kemet
  module Areas
    class Sanctuary < Area # :nodoc:
      def initialize(id, options)
        @id = id
        @options = options

        super
      end

      def obelysk?
        true
      end

      def sanctuary?
        true
      end
    end
  end
end
