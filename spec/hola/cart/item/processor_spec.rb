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
      described_class
        .new(product_id: product.id, quantity: quantity)
        .perform
    end

    let(:product) do
      instance_double(Hola::Product, id: id, price: BigDecimal("3.11"), offer: offer)
    end
    let(:id) { "98a870aa-aa9b-4291-8193-18d361e3a453" }
    let(:quantity) { 2 }
    let(:offer) { "" }
    let(:subtotal) { product.price * quantity }

    before do
      allow(Hola::Product).to receive(:find).and_return(product)
    end

    it "returns cart item class" do
      expect(subject.class).to be(Hola::Cart::Item)
    end

    it "creates cart item with arguments" do
      expect(Hola::Cart::Item).to receive(:new).with(
        product: product,
        quantity: quantity,
        subtotal: subtotal
      )
      subject
    end

    it "computes subtotal as product of price and quantity" do
      expect(subject.subtotal).to eq(subtotal)
    end

    context "product has an offer" do
      let(:offer) { "GetOneFree" }

      let(:get_one_free) { instance_double(Hola::Offer::GetOneFree) }

      before do
        allow(Hola::Offer::GetOneFree).to receive(:new).with(
          product: product,
          quantity: quantity
        ).and_return(get_one_free)
        allow(get_one_free).to receive(:apply)
      end

      it "calls Offer::GetOneFree" do
        subject
        expect(get_one_free).to have_received(:apply)
      end
    end
  end
end
