# frozen_string_literal: true

require "spec_helper"
require "hola/cart"

RSpec.describe Hola::Cart do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Cart)
  end

  let(:instance) { described_class.new }

  describe ".add" do
    subject do
      instance.add(product_id: product_id, quantity: quantity)
    end

    let(:product_id) { "xxx" }
    let(:quantity) { 3 }

    let(:product) { instance_double(Hola::Product, price: 3.11) }

    before do
      allow(Hola::Product).to receive(:find).and_return(product)
    end

    it "adds quantity to item" do
      subject
      expect(instance.items[product_id]).to eq(quantity)
    end

    it "increases total" do
      subject
      expect(instance.total).to eq(product.price * quantity)
    end
  end

  describe ".output" do
    subject do
      instance.output
    end

    let(:product) { instance_double(Hola::Product, name: "x", price: 3.11) }

    before do
      allow(Hola::Product).to receive(:find).and_return(product)
      allow(instance).to receive(:items).and_return({
        "xxx" => 2,
        "yyy" => 3
      })
    end

    it "returns array of products" do
      expect(subject).to match_array([
        ["x", 2, "6.22"],
        ["x", 3, "9.33"],
      ])
    end
  end
end
