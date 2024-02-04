# frozen_string_literal: true

require "tty-prompt"
require "hola/product"

# This class provides an interface for a user to select a product
module Hola
  class Product
    class Selector
      def initialize(prompt)
        @prompt = prompt
      end

      def perform
        {
          product_id: select_product,
          quantity: select_quantity
        }
      end

      private

      attr_reader :prompt

      def product_options
        @product_options ||= Product.list.map(&:to_option)
      end

      def select_product
        prompt.select("Choose a product", product_options)
      end

      def select_quantity
        prompt.ask(
          "Select quantity (stock: 100)? ",
          convert: :int
        ) do |q|
          q.in("1-100")
          q.messages[:range?] = "out of expected range"
          q.messages[:convert?] = "not a number"
        end
      end
    end
  end
end
