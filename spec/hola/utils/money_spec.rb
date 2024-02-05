# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hola::Utils::Money do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Utils::Money)
  end

  describe "#parse" do
    let(:value) { 3.11 }
    subject { described_class.parse(value) }

    it "parses value to BigDecimal" do
      expect(subject).to eq(BigDecimal("3.11"))
    end

    context "provided value is nil" do
      let(:value) { nil }

      it "returns zero in big decimal" do
        expect(subject).to eq(BigDecimal("0"))
      end
    end
  end
end
