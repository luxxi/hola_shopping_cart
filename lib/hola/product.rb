# frozen_string_literal: true

require "securerandom"

module Hola
  class Product
    class << self
      def list
        @list ||= [
          Product.new(name: "Green Tea", price: 3.11, offer: "GetOneFree"),
          Product.new(name: "Strawberries", price: 5.0, offer: "StrawberryBulkDiscount"),
          Product.new(name: "Coffee", price: 11.23, offer: "TwoThirdsBulkDiscount")
        ]
      end

      def find(id)
        list.find { |p| p.id == id }
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
