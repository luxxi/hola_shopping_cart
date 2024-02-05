# frozen_string_literal: true

require "spec_helper"
require "bigdecimal"
require "hola/cart/item/subtotal"

RSpec.describe Hola::Cart::Item::Subtotal do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Cart::Item::Subtotal)
  end

  describe ".compute" do
    let(:price) { BigDecimal("3.11") }
    let(:quantity) { 2 }
    let(:discount) { BigDecimal("0.8") }
    let(:args) { {price: price, quantity: quantity, discount: discount} }

    subject { described_class.new(**args).compute }

    before do
      allow(Hola::Utils::Discount).to receive(:parse).and_call_original
    end

    it "parses discount" do
      subject
      expect(Hola::Utils::Discount).to have_received(:parse).with(discount)
    end

    it "returns big decimal" do
      expect(subject.class).to be(BigDecimal)
    end

    context "qunatity is zero" do
      let!(:quantity) { 0 }

      it "raises ArgumentError" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context "discount not provided" do
      let(:args) { {price: price, quantity: quantity} }

      it "should not affect subtotal" do
        expect(subject).to eq(price * quantity)
      end
    end

    context "discount is valid" do
      context "float value" do
        let(:discount) { 0.8 }

        it "should affect subtotal" do
          expect(subject).to eq(price * quantity * discount)
        end
      end

      context "big decimal value" do
        let(:discount) { BigDecimal("0.8") }

        it "should affect subtotal" do
          expect(subject).to eq(price * quantity * discount)
        end
      end
    end

    context "discount is not valid" do
      context "discount is out of range" do
        context "string value" do
          let(:discount) { "1.2" }

          it "should not affect subtotal" do
            expect(subject).to eq(price * quantity)
          end
        end

        context "big decimal value" do
          let(:discount) { BigDecimal("1.2") }

          it "should not affect subtotal" do
            expect(subject).to eq(price * quantity)
          end
        end
      end

      context "discount is nil" do
        let(:discount) { nil }

        it "should not affect subtotal" do
          expect(subject).to eq(price * quantity)
        end
      end

      context "discount is empty string" do
        let(:discount) { "" }

        it "should not affect subtotal" do
          expect(subject).to eq(price * quantity)
        end
      end
    end
  end
end
