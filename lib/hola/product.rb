# frozen_string_literal: true

require "hola/product/inventory"
require "securerandom"

module Hola
  class Product
    class << self
      def list
        Inventory.instance.products
      end

      def find(id)
        Inventory.instance.find_product(id)
      end

      def currency
        "€"
      end
    end

    attr_reader :id, :name, :price, :offer

    def initialize(name:, price:, offer: "")
      @id = SecureRandom.uuid
      @name = name
      @price = price
      @offer = offer
    end

    def to_option
      {name: title, value: id}
    end

    private

    def title
      "#{name} (#{format("%.2f", price)}#{self.class.currency})"
    end
  end
end
