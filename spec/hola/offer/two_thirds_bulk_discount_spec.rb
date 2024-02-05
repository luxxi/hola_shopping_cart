# frozen_string_literal: true

require "spec_helper"
require "hola/offer/two_thirds_bulk_discount"

RSpec.describe Hola::Offer::TwoThirdsBulkDiscount do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Offer::TwoThirdsBulkDiscount)
  end

  it_behaves_like :offer

  describe ".apply" do
    let(:price) { BigDecimal("11.23") }
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
      let(:discount) { 2.0 / 3.0 }

      it "computes subtotal" do
        expect(subject.subtotal).to eq(price * discount * quantity)
      end

      it "includes offer name" do
        expect(subject.offer).to eq("Two-Thirds Bulk Discount")
      end
    end
  end
end
