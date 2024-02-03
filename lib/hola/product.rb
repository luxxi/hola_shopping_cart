# frozen_string_literal: true

require "securerandom"

module Hola
  class Product
    class << self
      def list
        @list ||= [
          Product.new(name: "Green Tea", price: 3.11),
          Product.new(name: "Strawberries", price: 5.0),
          Product.new(name: "Coffee", price: 11.23)
        ]
      end

    end

    attr_reader :id, :name, :price

    def initialize(name:, price:)
      @id = SecureRandom.uuid
      @name = name
      @price = price
    end
  end
end
