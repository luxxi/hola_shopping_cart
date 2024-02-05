# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hola::Utils::Discount do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Utils::Discount)
  end

  describe "#parse" do
    let(:value) { 0.5 }
    subject { described_class.parse(value) }

    it "parses value to BigDecimal" do
      expect(subject).to eq(BigDecimal("0.5"))
    end

    context "provided value is less than 0" do
      let(:value) { -0.1 }

      it "returns 1 in big decimal" do
        expect(subject).to eq(BigDecimal("1"))
      end
    end

    context "provided value is more than 1" do
      let(:value) { 1.2 }

      it "returns 1 in big decimal" do
        expect(subject).to eq(BigDecimal("1"))
      end
    end

    context "provided value is nil" do
      let(:value) { nil }

      it "returns 1 in big decimal" do
        expect(subject).to eq(BigDecimal("1"))
      end
    end
  end
end
