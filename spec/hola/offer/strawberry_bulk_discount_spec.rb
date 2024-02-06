# frozen_string_literal: true

require "spec_helper"
require "hola/offer/strawberry_bulk_discount"

RSpec.describe Hola::Offer::StrawberryBulkDiscount do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Offer::StrawberryBulkDiscount)
  end

  it_behaves_like :offer

  let(:price) { BigDecimal("3.11") }
  let(:product) { instance_double(Hola::Product, price: price) }
  let(:quantity) { 1 }

  subject { described_class.new(product: product, quantity: quantity) }

  it "includes offer name" do
    expect(subject.name).to eq("Strawberry Bulk Discount")
  end

  context "quantity of 1" do
    let(:quantity) { 1 }

    it "does not affect subtotal computation" do
      expect(subject.subtotal).to eq(price * quantity)
    end

    it "does not apply offer" do
      expect(subject.applied?).to eq(false)
    end
  end

  context "quantity of 2" do
    let(:quantity) { 2 }

    it "does not affect subtotal computation" do
      expect(subject.subtotal).to eq(price * quantity)
    end

    it "does not apply offer" do
      expect(subject.applied?).to eq(false)
    end
  end

  context "quantity of 3" do
    let(:quantity) { 3 }

    it "does affect subtotal computation by reduced price" do
      expect(subject.subtotal).to eq(described_class::DISCOUNTED_PRICE * quantity)
    end

    it "does apply offer" do
      expect(subject.applied?).to eq(true)
    end
  end
end
