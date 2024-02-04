# frozen_string_literal: true

require "hola/cart/item"
require "hola/offer"
Dir.glob(File.expand_path("../../offer/*.rb", __dir__), &method(:require))

module Hola
  class Cart
    class Item
      class Processor
        attr_reader :product_id, :quantity

        def initialize(product_id:, quantity:)
          @product_id = product_id
          @quantity = quantity
        end

        def perform
          return default_cart_item unless product.offer

          Object.const_get("Hola::Offer::#{product.offer}")
            .new(product: product, quantity: quantity)
            .apply
        rescue NameError
          default_cart_item
        end

        private

        def product
          @product ||= Product.find(product_id)
        end

        def default_cart_item
          Cart::Item.new(
            product: product,
            quantity: quantity,
            subtotal: default_subtotal
          )
        end

        def default_subtotal
          @default_subtotal ||= product.price * quantity
        end
      end
    end
  end
end
