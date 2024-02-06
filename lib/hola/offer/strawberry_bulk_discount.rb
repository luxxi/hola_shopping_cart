# frozen_string_literal: true

require "bigdecimal"

module Hola
  class Offer
    class StrawberryBulkDiscount < Offer
      DISCOUNTED_PRICE = BigDecimal("4.5")

      def name
        "Strawberry Bulk Discount"
      end

      def price
        eligible? ? DISCOUNTED_PRICE : super
      end

      def applied?
        eligible?
      end

      private

      def eligible?
        quantity >= 3
      end
    end
  end
end
