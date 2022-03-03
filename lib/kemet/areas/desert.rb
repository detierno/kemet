# frozen_string_literal: true

module Kemet
  module Areas
    class Desert < Area  # :nodoc:
      def initialize(id, obelysk: false)
        @id = id
        @obelysk = obelysk

        super
      end

      def obelysk?
        @obelysk
      end
    end
  end
end
