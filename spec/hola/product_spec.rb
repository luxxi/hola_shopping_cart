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
  end
end
