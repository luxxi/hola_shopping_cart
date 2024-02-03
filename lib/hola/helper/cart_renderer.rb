# frozen_string_literal: true

require "tty-table"

module Hola
  module Helper
    class CartRenderer
      def perform
        table.render(:ascii)
      end

      private

      def table
        @table ||= TTY::Table.new(
          header: ["Item", "Quantity", "Price(€)"],
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
