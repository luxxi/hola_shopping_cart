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

        def to_currency(...)
          new(...).to_currency
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

      def to_currency
        "#{format("%.2f", value)}#{Product.currency}"
      end

      private

      attr_reader :value
    end
  end
end
