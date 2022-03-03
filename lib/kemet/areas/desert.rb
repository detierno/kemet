# frozen_string_literal: true

module Kemet
  module Areas
    class Desert < Area  # :nodoc:
      def initialize(id, obelysk: false)
        @obelysk = obelysk

        super(id)
      end

      def obelysk?
        @obelysk
      end
    end
  end
end
