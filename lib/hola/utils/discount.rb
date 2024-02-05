# frozen_string_literal: true

require "bigdecimal"

module Hola
  module Utils
    class Discount
      class << self
        def parse(...)
          new(...).parse
        end
      end

      def initialize(value)
        @value = value
      end

      def parse
        BigDecimal((value || 0).to_s.strip).tap do |discount|
          raise ArgumentError if discount <= 0 || discount > 1
        end
      rescue TypeError, ArgumentError
        BigDecimal(1)
      end

      private

      attr_reader :value
    end
  end
end
