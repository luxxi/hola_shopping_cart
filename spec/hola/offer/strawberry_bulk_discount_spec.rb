# frozen_string_literal: true

require "spec_helper"
require "hola/offer/strawberry_bulk_discount"

RSpec.describe Hola::Offer::StrawberryBulkDiscount do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Offer::StrawberryBulkDiscount)
  end

  it_behaves_like :offer

  describe ".apply" do
    let(:price) { BigDecimal("5") }
    let(:product) { instance_double(Hola::Product, price: price) }
    let(:instance) { described_class.new(product: product, quantity: quantity) }

    subject { instance.apply }

    before do
      allow(Hola::Cart::Item).to receive(:new).and_call_original
    end

    context "quantity of 1" do
      let(:quantity) { 1 }

      it "computes subtotal" do
        expect(subject.subtotal).to eq(price)
      end

      it "includes offer name" do
        expect(subject.offer).to be nil
      end
    end

    context "quantity of 2" do
      let(:quantity) { 2 }

      it "computes subtotal" do
        expect(subject.subtotal).to eq(price * quantity)
      end

      it "includes offer name" do
        expect(subject.offer).to be nil
      end
    end

    context "quantity of 3" do
      let(:quantity) { 3 }

      it "computes subtotal" do
        expect(subject.subtotal).to eq(
          described_class::DISCOUNTED_PRICE * quantity
        )
      end

      it "includes offer name" do
        expect(subject.offer).to eq("Strawberry Bulk Discount")
      end
    end
  end
end
