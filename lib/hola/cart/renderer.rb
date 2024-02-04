# frozen_string_literal: true

require "tty-table"
require "hola/product"

# Renders cart in table format
module Hola
  class Cart
    class Renderer
      def initialize(cart)
        @cart = cart
      end

      def perform
        table.render(:ascii)
      end

      private

      attr_reader :cart

      def table
        @table ||= TTY::Table.new(
          header: [
            "Item",
            "Price(#{currency})",
            "Quantity",
            "Subtotal(#{currency})",
            "Offer"
          ],
          rows: [
            :separator,
            *cart.output,
            :separator,
            ["Total", "", "", format("%.2f", cart.total), ""]
          ]
        )
      end

      def currency
        @currency ||= Product.currency
      end
    end
  end
end
