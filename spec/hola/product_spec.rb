require "spec_helper"
require "hola/product"

module Hola
  RSpec.describe Product do
    it "is available as described_class" do
      expect(described_class).to eq(Product)
    end

    describe "#list" do
      subject { described_class.list }

      it "returns array" do
        expect(subject.class).to be(Array)
      end

      it "returns non empty array" do
        expect(subject).to_not be_empty
      end

      it "returns list of products" do
        expect(subject.first.class).to be(Product)
      end
    end

    describe "#find" do
      subject { described_class.find(id) }

      let(:product) { described_class.list.first }
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
end
