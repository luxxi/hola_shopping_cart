# frozen_string_literal: true

require "tty-prompt"

module Hola
  class App
    def initialize(prompt = nil)
      @prompt = prompt
    end

    def run
      prompt.say("Hola. It's shopping time 🛍️")

      select_product
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
  end
end
