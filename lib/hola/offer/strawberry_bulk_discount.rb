# frozen_string_literal: true

require "hola/cart/item"

module Hola
  class Offer
    class StrawberryBulkDiscount < Offer
      DISCOUNTED_PRICE = 4.5

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
        price * quantity
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
