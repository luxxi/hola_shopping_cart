# frozen_string_literal: true

require "hola/product"

module Hola
  class Cart
    attr_reader :items, :total

    def initialize
      @items = Hash.new(0)
      @total = 0
    end

    def add(product_id:, quantity:)
      items[product_id] = quantity
      @total += product(product_id)&.price * quantity
    end
    private

    def product(id)
      @product ||= Product.find(id)
    end
  end
end

