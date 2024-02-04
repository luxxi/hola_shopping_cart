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
    let(:subtotal) { 6.0 }

    let(:processor) { instance_double(Hola::Cart::Item::Processor) }
    let(:item) do
      instance_double(Hola::Cart::Item, quantity: quantity, subtotal: subtotal)
    end

    before do
      allow(Hola::Cart::Item).to receive(:new).and_return(item)
      allow(Hola::Cart::Item::Processor).to receive(:new).and_return(processor)
      allow(processor).to receive(:perform).and_return(item)
    end

    it "performs cart item processor" do
      subject
      expect(processor).to have_received(:perform)
    end

    it "returns cart item" do
      expect(subject).to be(item)
    end
  end

  describe ".total" do
    subject do
      instance.total
    end

    let(:subtotal) { 4.55 }
    let(:item1) { instance_double(Hola::Cart::Item, subtotal: subtotal) }
    let(:item2) { instance_double(Hola::Cart::Item, subtotal: subtotal) }

    before do
      allow(instance).to receive(:items).and_return({
        "xxx" => item1,
        "yyy" => item2
      })
    end

    it "computes the sum of multiple items" do
      expect(subject).to eq(subtotal * 2)
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
