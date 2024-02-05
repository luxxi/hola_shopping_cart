# frozen_string_literal: true

require "spec_helper"
require "hola/offer/get_one_free"

RSpec.describe Hola::Offer::GetOneFree do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Offer::GetOneFree)
  end

  it_behaves_like :offer

  describe ".apply" do
    let(:price) { BigDecimal("3.11") }
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

      it "sends quantity to subtotal calculation" do
        subject

        aggregate_failures("verifying subtotal call") do
          expect(Hola::Cart::Item::Subtotal).to have_received(:new).with(
            price: product.price,
            quantity: quantity
          )
          expect(subtotal).to have_received(:compute)
        end
      end

      it "includes offer name" do
        expect(subject.offer).to be nil
      end
    end

    context "quantity of 2" do
      let(:quantity) { 2 }

      it "sends reduced quantity to subtotal calculation" do
        subject

        aggregate_failures("verifying subtotal call") do
          expect(Hola::Cart::Item::Subtotal).to have_received(:new).with(
            price: product.price,
            quantity: quantity - 1
          )
          expect(subtotal).to have_received(:compute)
        end
      end

      it "includes offer name" do
        expect(subject.offer).to eq("Get One Free")
      end
    end

    context "quantity of 3" do
      let(:quantity) { 3 }

      it "sends reduced quantity to subtotal calculation" do
        subject

        aggregate_failures("verifying subtotal call") do
          expect(Hola::Cart::Item::Subtotal).to have_received(:new).with(
            price: product.price,
            quantity: quantity - 1
          )
          expect(subtotal).to have_received(:compute)
        end
      end

      it "includes offer name" do
        expect(subject.offer).to eq("Get One Free")
      end
    end
  end
end
