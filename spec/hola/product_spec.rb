require "spec_helper"
require "hola/product"
require "hola/utils/money"

module Hola
  RSpec.describe Product do
    it "is available as described_class" do
      expect(described_class).to eq(Product)
    end

    let(:name) { "Strawberries" }
    let(:price) { 3.4 }
    let(:offer) { nil }

    subject { described_class.new(name: name, price: price, offer: offer) }

    before do
      allow(Hola::Utils::Money).to receive(:parse).and_call_original
    end

    it "parses price" do
      subject.price
      expect(Hola::Utils::Money).to have_received(:parse).with(price)
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

    describe "#currency" do
      subject { described_class.currency }

      it "returns EUR sign" do
        expect(subject).to eq("€")
      end
    end

    describe ".to_option" do
      subject do
        described_class.new(name: name, price: price, offer: offer).to_option
      end

      it "returns a hash" do
        expect(subject.class).to be(Hash)
      end

      it "returns title including name" do
        expect(subject[:name]).to include("Strawberries")
      end

      it "returns title including formatted price to two decimals" do
        expect(subject[:name]).to include("3.40")
      end

      it "returns title including currency sign" do
        expect(subject[:name]).to include("€")
      end

      it "returns generated uuid as id" do
        expect(subject[:value]).to be_a_uuid
      end
    end
  end
end
