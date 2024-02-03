# frozen_string_literal: true

require "tty-prompt"
require "hola/helper/product_selector"
require "hola/helper/cart_renderer"

module Hola
  class App
    def initialize(prompt = nil)
      @prompt = prompt
    end

    def run
      prompt.say("Hola. It's shopping time 🛍️")

      loop do
        Helper::ProductSelector.new(prompt).perform

        break unless prompt.yes?("Would you like to add more items?")
      end

      prompt.say(Helper::CartRenderer.new.perform)
    end

    private

    def prompt
      @prompt ||= TTY::Prompt.new
    end
  end
end
