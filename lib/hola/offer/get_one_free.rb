# frozen_string_literal: true

module Hola
  class Offer
    class GetOneFree < Offer
      def name
        "Get One Free"
      end

      def quantity
        @_quantity ||= super - quantity_reduction
      end

      def applied?
        eligible?
      end

      private

      def quantity_reduction
        eligible? ? 1 : 0
      end

      def eligible?
        @quantity > 1
      end
    end
  end
end
