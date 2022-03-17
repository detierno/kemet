# frozen_string_literal: true

module Kemet
  module Areas
    # Abstract concept wrapping connected districts, does not
    # have direct effect on the board
    class City
      attr_reader :districts, :owner

      def initialize(owner, districts)
        @owner = owner
        @districts = districts
      end
    end
  end
end
