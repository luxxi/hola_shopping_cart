# frozen_string_literal: true

require "hola/product/inventory"
require "hola/utils/money"
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
      @price = Utils::Money.parse(price)
      @offer = offer
    end

    def offer?
      !offer.empty?
    end

    def to_option
      {name: title, value: id}
    end

    def apply_offer(name)
      self.offer = name
    end

    private

    attr_writer :offer

    def title
      "#{name} (#{Utils::Money.to_currency(price)})"
    end
  end
end
