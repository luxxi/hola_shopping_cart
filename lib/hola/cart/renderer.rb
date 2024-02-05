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
          header: %w[Item Price Quantity Subtotal Offer],
          rows: [
            :separator,
            *cart.output,
            :separator,
            ["Total", "", "", Utils::Money.to_currency(cart.total), ""]
          ]
        )
      end
    end
  end
end
