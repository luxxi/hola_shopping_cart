# frozen_string_literal: true

require "bigdecimal"

module Hola
  class Offer
    class TwoThirdsBulkDiscount < Offer
      def name
        "Two-Thirds Bulk Discount"
      end

      def price
        super * discount
      end

      def applied?
        eligible?
      end

      private

      def discount
        return BigDecimal(1) unless eligible?

        BigDecimal(2) / BigDecimal(3)
      end

      def eligible?
        quantity >= 3
      end
    end
  end
end
