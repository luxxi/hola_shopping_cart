# frozen_string_literal: true

require "tty-prompt"

module Hola
  class App
    def initialize(prompt = nil)
      @prompt = prompt
    end

    def run
      prompt.say("Hola. It's shopping time 🛍️")
    end

    private

    def prompt
      @prompt ||= TTY::Prompt.new
    end
  end
end
