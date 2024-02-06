# frozen_string_literal: true

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
          Cart::Item.new(
            product: product,
            quantity: quantity,
            subtotal: offer.subtotal,
            offer: (offer.name if offer.applied?)
          )
        end

        private

        def product
          @product ||= Product.find(product_id)
        end

        def offer
          @offer ||= begin
            klass = product.offer? ? product.offer : "NoOffer"
            Object.const_get("Hola::Offer::#{klass}").new(
              product: product,
              quantity: quantity
            )
          end
        rescue NameError
          raise ArgumentError.new("Offer not found")
        end
      end
    end
  end
end
