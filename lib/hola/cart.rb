# frozen_string_literal: true

require "hola/cart/item"
require "hola/product"

module Hola
  class Cart
    attr_reader :items, :total

    def initialize
      @items = Hash.new { Cart::Item.new }
      @total = 0
    end

    def add(product_id:, quantity:)
      items[product_id] = Cart::Item.new(
        product: product(product_id),
        quantity: quantity
      )
      @total += items[product_id].subtotal
    end
    def output
      items.map { |_k, item| item.output }
    end

    private

    def product(id)
      Product.find(id)
    end
  end
end

