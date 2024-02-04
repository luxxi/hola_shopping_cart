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



    let(:item) { instance_double(Hola::Cart::Item) }

    before do
      allow(Hola::Cart::Item).to receive(:new).and_return(item)
    end

    it "adds item to cart" do
      subject
      expect(instance.items[product_id]).to eq(item)
    end
  end

  describe ".output" do
    subject do
      instance.output
    end

    let(:item1) { instance_double(Hola::Cart::Item, output: ["a"]) }
    let(:item2) { instance_double(Hola::Cart::Item, output: ["b"]) }

    before do
      allow(instance).to receive(:items).and_return({
        "xxx" => item1,
        "yyy" => item2
      })
    end

    it "returns combined output from items" do
      expect(subject).to match_array([["a"], ["b"]])
    end
  end
end
