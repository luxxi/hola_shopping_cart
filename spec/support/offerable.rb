# frozen_string_literal: true

RSpec.shared_examples :offer do
  let(:product) { instance_double(Hola::Product) }
  let(:quantity) { 3 }

  subject { described_class.new(product: product, quantity: quantity) }

  it { expect(subject).to respond_to(:subtotal) }
  it { expect(described_class).to be < Hola::Offer }
end
