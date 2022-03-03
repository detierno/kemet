# frozen_string_literal: true

module Kemet
  module Areas
    class Sanctuary < Area # :nodoc:
      def initialize(id, options)
        @options = options

        super(id)
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
