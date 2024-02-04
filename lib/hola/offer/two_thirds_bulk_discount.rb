# frozen_string_literal: true

require "hola/cart/item"

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
        product.price * discount * quantity
      end

      def discount
        return 1 unless eligible?

        2.0 / 3.0
      end

      def eligible?
        quantity >= 3
      end
    end
  end
end
