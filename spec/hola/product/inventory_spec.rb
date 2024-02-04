# frozen_string_literal: true

require "spec_helper"
require "hola/product/inventory"

RSpec.describe Hola::Product::Inventory do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Product::Inventory)
  end

  describe ".products" do
    subject { described_class.instance.products }

    it "returns array" do
      expect(subject.class).to be(Array)
    end
  end

  describe ".find_product" do
    subject { described_class.instance.find_product(id) }

    let(:product) { described_class.instance.products.first }
    let(:id) { product.id }

    it "finds correct product" do
      expect(subject).to eq(product)
    end

    context "id does not exist" do
      let(:id) { "xxx" }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end

    context "id is nil" do
      let(:id) { nil }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end
  end
end
