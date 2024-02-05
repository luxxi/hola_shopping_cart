# frozen_string_literal: true

require "spec_helper"
require "hola/offer/two_thirds_bulk_discount"
require "hola/cart/item/subtotal"

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

    let(:subtotal) { instance_double(Hola::Cart::Item::Subtotal) }

    before do
      allow(Hola::Cart::Item).to receive(:new).and_call_original
      allow(Hola::Cart::Item::Subtotal).to receive(:new).and_return(subtotal)
      allow(subtotal).to receive(:compute)
    end

    context "quantity of 1" do
      let(:quantity) { 1 }

      it "sends discount 1 to subtotal calculation" do
        subject

        aggregate_failures("verifying subtotal call") do
          expect(Hola::Cart::Item::Subtotal).to have_received(:new).with(
            price: price,
            quantity: quantity,
            discount: BigDecimal(1)
          )
          expect(subtotal).to have_received(:compute)
        end
      end

      it "does not include offer name" do
        expect(subject.offer).to be nil
      end
    end

    context "quantity of 2" do
      let(:quantity) { 2 }

      it "sends discount 1 to subtotal calculation" do
        subject

        aggregate_failures("verifying subtotal call") do
          expect(Hola::Cart::Item::Subtotal).to have_received(:new).with(
            price: price,
            quantity: quantity,
            discount: BigDecimal(1)
          )
          expect(subtotal).to have_received(:compute)
        end
      end

      it "does not include offer name" do
        expect(subject.offer).to be nil
      end
    end

    context "quantity of 3" do
      let(:quantity) { 3 }

      it "sends discount 1 to subtotal calculation" do
        subject

        aggregate_failures("verifying subtotal call") do
          expect(Hola::Cart::Item::Subtotal).to have_received(:new).with(
            price: price,
            quantity: quantity,
            discount: BigDecimal(2) / BigDecimal(3)
          )
          expect(subtotal).to have_received(:compute)
        end
      end

      it "includes offer name" do
        expect(subject.offer).to eq("Two-Thirds Bulk Discount")
      end
    end
  end
end
