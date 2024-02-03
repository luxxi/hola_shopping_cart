# frozen_string_literal: true

require "tty-prompt"

module Hola
  class App
    def initialize(prompt = nil)
      @prompt = prompt
    end

    def run
      prompt.say("Hola. It's shopping time 🛍️")

      loop do
        select_product
        select_quantity
        break unless prompt.yes?("Would you like to add more items?")
      end
    end

    private

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def select_product
      prompt.select(
        "Please choose product",
        ["Green Tea (3.11€)", "Strawberries (5.00€)", "Coffee (11.23€)"]
      )
    end

    def select_quantity
      text = "How much quantity would you like to add in cart (stock: 100)? "
      prompt.ask(text, convert: :int) do |q|
        q.in("1-100")
        q.messages[:range?] = "out of expected range"
        q.messages[:convert?] = "not a number"
      end
    end
  end
end
