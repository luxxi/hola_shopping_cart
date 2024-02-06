# frozen_string_literal: true

require "spec_helper"
require "hola/cart/item/processor"
require "hola/cart/item"
require "hola/product"

RSpec.describe Hola::Cart::Item::Processor do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Cart::Item::Processor)
  end

  describe ".perform" do
    subject do
      described_class.new(product_id: id, quantity: quantity).perform
    end

    let(:product) do
      instance_double(Hola::Product, price: price, offer: offer, offer?: offer?)
    end
    let(:id) { "98a870aa-aa9b-4291-8193-18d361e3a453" }
    let(:quantity) { 2 }
    let(:price) { BigDecimal("3.11") }
    let(:subtotal) { price * quantity }
    let(:offer) { nil }
    let(:offer?) { false }
    let(:offer_applied) { false }
    let(:offer_stub) { instance_double(Hola::Offer) }

    before do
      allow(Hola::Product).to receive(:find).and_return(product)
      allow(Hola::Offer).to receive(:new).and_return(offer_stub)
      allow(offer_stub).to receive(:subtotal).and_return(subtotal)
      allow(offer_stub).to receive(:applied?).and_return(offer_applied)
    end

    it "returns cart item class" do
      expect(subject.class).to be(Hola::Cart::Item)
    end

    it "creates cart item with arguments" do
      expect(Hola::Cart::Item).to receive(:new).with(
        product: product,
        quantity: quantity,
        subtotal: offer_stub.subtotal,
        offer: offer
      )
      subject
    end

    context "product has offer" do
      let(:offer) { "GetOneFree" }
      let(:offer?) { true }
      let(:get_one_free) do
        instance_double(Hola::Offer::GetOneFree)
      end
      let(:subtotal) { price }

      before do
        allow(Hola::Offer::GetOneFree).to receive(:new).with(
          product: product,
          quantity: quantity
        ).and_return(get_one_free)
        allow(get_one_free).to receive(:subtotal).and_return(subtotal)
        allow(get_one_free).to receive(:name).and_return(offer)
        allow(get_one_free).to receive(:applied?).and_return(offer_applied)
      end

      it "calls Offer::GetOneFree" do
        subject

        aggregate_failures("verifying calls") do
          expect(get_one_free).to have_received(:subtotal)
          expect(get_one_free).to have_received(:applied?)
        end
      end

      context "when offer is applied" do
        let(:offer_applied) { true }

        it "creates cart item with arguments" do
          expect(Hola::Cart::Item).to receive(:new).with(
            product: product,
            quantity: quantity,
            subtotal: get_one_free.subtotal,
            offer: offer
          )
          subject
        end

        it "has offer name" do
          expect(subject.offer).to eq(offer)
        end
      end

      context "when quantity is 1 and offer is not applied" do
        let(:quantity) { 1 }
        let(:offer_applied) { false }

        it "creates cart item with arguments" do
          expect(Hola::Cart::Item).to receive(:new).with(
            product: product,
            quantity: quantity,
            subtotal: get_one_free.subtotal,
            offer: nil
          )
          subject
        end

        it "has offer name" do
          expect(subject.offer).to be(nil)
        end
      end
    end

    context "when offer implementation is missing" do
      let(:offer) { "not_implemented" }
      let(:offer?) { true }

      it "creates cart item with arguments" do
        expect { subject }.to raise_error(ArgumentError, "Offer not found")
      end
    end
  end
end
