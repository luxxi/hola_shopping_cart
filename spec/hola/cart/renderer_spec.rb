# frozen_string_literal: true

require "spec_helper"
require "tty-prompt"
require "tty/prompt/test"
require "hola/cart/renderer"
require "hola/cart"

RSpec.describe Hola::Cart::Renderer do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Cart::Renderer)
  end

  describe ".perform" do
    subject { described_class.new(cart).perform }

    let(:cart) { Hola::Cart.new }
    let(:table) { instance_double(TTY::Table) }
    before do
      allow(TTY::Table).to receive(:new).and_return(table)
      allow(table).to receive(:render)
    end

    it "renders cart output" do
      subject
      expect(table).to have_received(:render)
    end
  end
end
