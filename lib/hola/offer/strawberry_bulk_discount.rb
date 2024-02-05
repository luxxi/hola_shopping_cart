# frozen_string_literal: true

require "bigdecimal"
require "hola/cart/item"
require "hola/cart/item/subtotal"

module Hola
  class Offer
    class StrawberryBulkDiscount < Offer
      DISCOUNTED_PRICE = BigDecimal("4.5")

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
        "Strawberry Bulk Discount"
      end

      def subtotal
        @subtotal ||= Cart::Item::Subtotal.new(
          price: price,
          quantity: quantity
        ).compute
      end

      def price
        eligible? ? DISCOUNTED_PRICE : product.price
      end

      def eligible?
        quantity >= 3
      end
    end
  end
end
