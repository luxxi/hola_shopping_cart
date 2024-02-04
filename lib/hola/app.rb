# frozen_string_literal: true

require "tty-prompt"
require "hola/helper/product_selector"
require "hola/helper/cart_renderer"
require "hola/cart"

# This class facilitates user flow experience.
# It allows user to select products and prints the cart.
module Hola
  class App
    def initialize(prompt = nil)
      @prompt = prompt
    end

    def run
      prompt.say("Hola. It's shopping time 🛍️")

      loop do
        selection = Helper::ProductSelector.new(prompt).perform
        cart.add(
          product_id: selection[:product_id],
          quantity: selection[:quantity]
        )

        break unless prompt.yes?("Would you like to add more items?")
      end

      prompt.say(Helper::CartRenderer.new(cart).perform)
    end

    private

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    def cart
      @cart ||= Cart.new
    end
  end
end
