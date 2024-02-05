# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hola::Utils::Money do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Utils::Money)
  end

  describe "#parse" do
    let(:value) { 64.4 }
    subject { described_class.parse(value) }

    it "parses value to BigDecimal" do
      expect(subject).to eq(BigDecimal("64.4"))
    end

    context "provided value is nil" do
      let(:value) { nil }

      it "returns zero in big decimal" do
        expect(subject).to eq(BigDecimal("0"))
      end
    end
  end

  describe "#to_currency" do
    let(:value) { BigDecimal("64.4") }
    subject { described_class.to_currency(value) }

    it "returns currency" do
      expect(subject).to eq("#{format("%.2f", value)}€")
    end
  end
end
