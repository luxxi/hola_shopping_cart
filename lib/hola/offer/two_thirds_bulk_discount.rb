# frozen_string_literal: true

require "bigdecimal"
require "hola/cart/item"
require "hola/cart/item/subtotal"

module Hola
  class Offer
    class TwoThirdsBulkDiscount < Offer
      def apply
        Cart::Item.new(
          product: product,
          quantity: quantity,
          subtotal: subtotal,
          offer: (name if eligible?)
        )
      end

      private

      def name
        "Two-Thirds Bulk Discount"
      end

      def subtotal
        @subtotal ||= Cart::Item::Subtotal.new(
          price: product.price,
          quantity: quantity,
          discount: discount
        ).compute
      end

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
