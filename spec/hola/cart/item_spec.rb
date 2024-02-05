# frozen_string_literal: true

require "spec_helper"
require "hola/cart/item"
require "hola/product"

RSpec.describe Hola::Cart::Item do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Cart::Item)
  end

  let(:instance) { described_class.new(product: product, quantity: quantity) }

  let(:quantity) { 3 }
  let(:product) do
    instance_double(Hola::Product, name: "Green Tea", price: 3.11)
  end

  describe ".output" do
    subject { instance.output }

    let(:subtotal) { 9.33 }

    before do
      allow(instance).to receive(:subtotal).and_return(subtotal)
    end

    it "returns output array" do
      aggregate_failures("verifying output") do
        expect(subject.class).to be(Array)
        expect(subject[0]).to eq(product.name)
        expect(subject[1]).to eq(Hola::Utils::Money.to_currency(product.price))
        expect(subject[2]).to eq(quantity)
        expect(subject[3]).to eq(Hola::Utils::Money.to_currency(subtotal))
      end
    end
  end
end
