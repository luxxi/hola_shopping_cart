# frozen_string_literal: true

require "bigdecimal"
require "hola/errors"

module Hola
  module Utils
    class Money
      class << self
        def parse(...)
          new(...).parse
        end
      end

      def initialize(value)
        @value = value
      end

      def parse
        BigDecimal((value || 0).to_s.strip)
      rescue ArgumentError, TypeError => err
        raise Error.new(err.message)
      end

      private

      attr_reader :value
    end
  end
end
