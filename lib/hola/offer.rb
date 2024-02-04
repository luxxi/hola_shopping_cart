# frozen_string_literal: true

module Hola
  class Offer
    attr_reader :product, :quantity

    def initialize(product:, quantity:)
      @product = product
      @quantity = quantity
    end

    def apply
      raise NotImplementedError
    end
  end
end
