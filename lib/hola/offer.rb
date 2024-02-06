# frozen_string_literal: true

# A parent class that all offers should inherit from
module Hola
  class Offer
    attr_reader :quantity

    def initialize(product:, quantity:)
      @product = product
      @quantity = quantity
    end

    def name
      ""
    end

    def price
      @price ||= product.price
    end

    def applied?
      false
    end

    def subtotal
      price * quantity
    end

    private

    attr_reader :product
  end
end
