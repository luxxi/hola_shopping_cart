# frozen_string_literal: true

module Hola
  class Cart
    class Item
      attr_reader :product, :quantity

      def initialize(product:, quantity:)
        @product = product
        @quantity = quantity
      end

      def subtotal
        product.price * quantity
      end

      def output
        [product.name, quantity, format("%.2f", subtotal)]
      end
    end
  end
end
