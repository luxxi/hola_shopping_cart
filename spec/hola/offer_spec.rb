# frozen_string_literal: true

require "spec_helper"
require "hola/offer"

RSpec.describe Hola::Offer do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Offer)
  end

  subject do
    described_class.new(product: product, quantity: quantity)
  end

  let(:quantity) { 3 }
  let(:price) { BigDecimal("3.11") }
  let(:product) { instance_double(Hola::Product, price: price) }

  it "responds to name" do
    expect(subject.name).to eq("")
  end

  it "responds to price" do
    expect(subject.price).to eq(price)
  end

  it "responds to quantity" do
    expect(subject.quantity).to eq(quantity)
  end

  it "responds to applied?" do
    expect(subject.applied?).to eq(false)
  end

  it "computes to subtotal" do
    expect(subject.subtotal).to eq(product.price * quantity)
  end
end
