# frozen_string_literal: true

require "bigdecimal"
require "hola/utils/money"
require "hola/utils/discount"

module Hola
  class Cart
    class Item
      class Subtotal
        attr_reader :price

        def initialize(price:, quantity:, discount: 1)
          @price = price
          @quantity = quantity
          @discount = discount
        end

        def compute
          price * quantity * discount
        end

        private

        def quantity
          @_quantity ||= @quantity.to_i.tap do |quantity|
            raise ArgumentError.new("Invalid amount") if quantity.zero?
          end
        end

        def discount
          @_discount ||= Utils::Discount.parse(@discount)
        end
      end
    end
  end
end
