# frozen_string_literal: true

require "hola/cart/item/processor"
require "hola/cart/item"
require "hola/product"

module Hola
  class Cart
    attr_reader :items

    def initialize
      @items = Hash.new { Cart::Item.new }
    end

    def add(product_id:, quantity:)
      items[product_id] = Cart::Item::Processor.new(
        product_id: product_id,
        quantity: quantity
      ).perform
    end

    def total
      items.sum { |_k, item| item.subtotal }
    end

    def output
      items.map { |_k, item| item.output }
    end
  end
end

