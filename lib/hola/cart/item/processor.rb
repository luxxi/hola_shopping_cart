# frozen_string_literal: true

require "hola/cart/item/subtotal"
require "hola/cart/item"
require "hola/offer"
Dir.glob(File.expand_path("../../offer/*.rb", __dir__), &method(:require))

# The item processor is responsible for processing the item before
# it's added to a cart. It applies the product's offer
# and responds with a cart item value object.
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
          return cart_item unless product.offer

          Object.const_get("Hola::Offer::#{product.offer}")
            .new(product: product, quantity: quantity)
            .apply
        rescue NameError
          cart_item
        end

        private

        def product
          @product ||= Product.find(product_id)
        end

        def cart_item
          @cart_item ||= Cart::Item.new(
            product: product,
            quantity: quantity,
            subtotal: subtotal
          )
        end

        def subtotal
          @subtotal ||= Cart::Item::Subtotal.new(
            price: product.price,
            quantity: quantity
          ).compute
        end
      end
    end
  end
end
