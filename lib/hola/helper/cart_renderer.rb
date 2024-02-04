# frozen_string_literal: true

require "tty-table"
require "hola/product"

module Hola
  module Helper
    class CartRenderer
      def perform
        table.render(:ascii)
      end

      private

      def table
        @table ||= TTY::Table.new(
          header: ["Item", "Quantity", "Price(#{Product.currency})"],
          rows: [
            :separator,
            ["Green Tea", 2, "3.11€"],
            :separator,
            ["Total", "", "3.11€"]
          ]
        )
      end
    end
  end
end
