# frozen_string_literal: true

require "tty-prompt"
require "hola/helper/product_selector"

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
    end

    private

    def prompt
      @prompt ||= TTY::Prompt.new
    end
  end
end
