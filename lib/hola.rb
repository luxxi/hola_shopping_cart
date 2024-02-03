# frozen_string_literal: true

require "hola/app"

module Hola
  class CLI
    class << self
      def start
        App.new.run
      end
    end
  end
end
