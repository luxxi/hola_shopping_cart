# frozen_string_literal: true

require "spec_helper"
require "hola/product/selector"
require "hola/product"
require "tty-prompt"
require "tty/prompt/test"

RSpec.describe Hola::Product::Selector do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Product::Selector)
  end

  describe ".perform" do
    let(:prompt) { TTY::Prompt::Test.new }

    subject { described_class.new(prompt).perform }

    let(:green_tea) { Hola::Product.new(name: "Green Tea", price: 3.11) }
    let(:strawberries) { Hola::Product.new(name: "Strawberries", price: 5.0) }
    let(:coffee) { Hola::Product.new(name: "Coffee", price: 11.23) }

    before do
      prompt.on :keypress do |e|
        prompt.trigger :keyup   if e.value == "k"
        prompt.trigger :keydown if e.value == "j"
      end

      allow(Hola::Product).to receive(:list).and_return(
        [green_tea, strawberries, coffee]
      )
    end

    it "prints correct output" do
      prompt.input << "\n" << 1 << "\n" << "n" << "\n"
      prompt.input.rewind
      subject
      aggregate_failures("verifying output") do
        expect(prompt.output.string).to include("Green Tea (3.11€)")
        expect(prompt.output.string).to include("Strawberries (5.00€)")
        expect(prompt.output.string).to include("Coffee (11.23€)")
        expect(prompt.output.string).to include(
          "How much quantity would you like to add in cart (stock: 100)?"
        )
      end
    end

    it "selects Strawberries with quantity of 1" do
      prompt.input << "j" << "\n" << "j" << "\n" << 1 << "\n" << "n" << "\n"
      prompt.input.rewind
      expect(subject).to include({product_id: strawberries.id, quantity: 1})
    end

    it "selects Green Tea with quantity of 3" do
      prompt.input << "\n" << 3 << "\n" << "n" << "\n"
      prompt.input.rewind
      expect(subject).to include({product_id: green_tea.id, quantity: 3})
    end

    it "selects Coffee with quantity of 2" do
      prompt.input << "j" << "j" << "j" << "\n" << 2 << "\n" << "n" << "\n"
      prompt.input.rewind
      expect(subject).to include({product_id: coffee.id, quantity: 2})
    end
  end
end
