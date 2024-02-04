# frozen_string_literal: true

require "singleton"
require "hola/product"

# The inventory stores products.
# The Hola shop has only 3 products in stock.
# This class can be extended to support bulk import of products from files
# provided via the command line or
# get completely replaced by the database in the future.
module Hola
  class Product
    class Inventory
      include Singleton
      attr_reader :products

      def initialize
        @products = [
          Product.new(name: "Green Tea", price: 3.11, offer: "GetOneFree"),
          Product.new(name: "Strawberries", price: 5.0, offer: "StrawberryBulkDiscount"),
          Product.new(name: "Coffee", price: 11.23, offer: "TwoThirdsBulkDiscount")
        ]
      end

      def find_product(id)
        products.find { |p| p.id == id }
      end
    end
  end
end
