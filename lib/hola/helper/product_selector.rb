# frozen_string_literal: true

require "tty-prompt"

module Hola
  module Helper
    class ProductSelector
      def initialize(prompt)
        @prompt = prompt
      end

      def perform
        prompt.collect do
          key(:product).select(
            "Please choose product",
            ["Green Tea (3.11€)", "Strawberries (5.00€)", "Coffee (11.23€)"]
          )
          key(:quantity).ask(
            "How much quantity would you like to add in cart (stock: 100)? ",
            convert: :int
          ) do |q|
            q.in("1-100")
            q.messages[:range?] = "out of expected range"
            q.messages[:convert?] = "not a number"
          end
        end
      end

      private

      attr_reader :prompt
    end
  end
end
