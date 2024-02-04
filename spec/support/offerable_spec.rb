# frozen_string_literal: true

require "hola/offer"
require "hola/product"
require "hola/cart/item"

RSpec.shared_examples :offer do
  let(:product) { instance_double(Hola::Product) }
  let(:quantity) { 3 }
  let(:instance) { described_class.new(product: product, quantity: quantity) }

  subject { instance }

  it { expect(subject).to respond_to(:apply) }
  it { expect(described_class).to be < Hola::Offer }

  describe ".apply" do
    subject { instance.apply }

    let(:product) { instance_double(Hola::Product, price: 3.11) }

    before do
      allow(Hola::Cart::Item).to receive(:new).and_call_original
    end

    it "responds with cart item" do
      aggregate_failures("verifying response") do
        expect(subject.class).to be(Hola::Cart::Item)
        expect(subject.product).to eq(product)
        expect(subject.quantity).to eq(quantity)
        expect(subject).to respond_to(:subtotal)
        expect(subject).to respond_to(:offer)
      end
    end
  end
end
