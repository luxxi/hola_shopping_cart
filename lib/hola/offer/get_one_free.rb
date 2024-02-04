# frozen_string_literal: true

require "hola/cart/item"

module Hola
  class Offer
    class GetOneFree < Offer
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
        "Get One Free"
      end

      def subtotal
        product.price * discounted_quantity
      end

      def discounted_quantity
        return quantity unless eligible?

        quantity - 1
      end

      def eligible?
        quantity > 1
      end
    end
  end
end
