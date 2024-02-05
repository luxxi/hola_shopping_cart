# frozen_string_literal: true

# Value object for Item in a Cart.
# It only knows how to display the values.
module Hola
  class Cart
    class Item
      attr_reader :product, :quantity, :subtotal, :offer

      def initialize(product: nil, quantity: 0, subtotal: 0, offer: "")
        @product = product
        @quantity = quantity
        @subtotal = subtotal
        @offer = offer
      end

      def output
        [
          product.name,
          Utils::Money.to_currency(product.price),
          quantity,
          Utils::Money.to_currency(subtotal),
          offer
        ]
      end
    end
  end
end
