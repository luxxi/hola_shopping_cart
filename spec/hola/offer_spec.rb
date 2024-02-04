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

  let(:product) { "xxx" }
  let(:quantity) { 3 }

  it "returns product" do
    expect(subject.product).to eq(product)
  end

  it "returns quantity" do
    expect(subject.quantity).to eq(quantity)
  end
end
