# frozen_string_literal: true

require "spec_helper"
require "hola/app"
require "tty-prompt"
require "tty/prompt/test"

RSpec.describe Hola::App do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::App)
  end

  describe ".run" do
    let(:prompt) { TTY::Prompt::Test.new }

    subject { described_class.new(prompt).run }

    let(:selector) { instance_double(Hola::Product::Selector) }
    let(:cart) { instance_double(Hola::Cart) }
    before do
      allow(Hola::Product::Selector).to receive(:new).and_return(selector)
      allow(selector).to receive(:perform).and_return({
        product_id: "792a7032-6d09-4533-9770-91ba37476e07",
        quantity: 2
      })
      allow(Hola::Cart).to receive(:new).and_return(cart)
      allow(cart).to receive(:add)
      allow(cart).to receive(:output)
      allow(cart).to receive(:total).and_return(3.11)
    end

    context "one product input" do
      before do
        prompt.input << "n" << "\n"
        prompt.input.rewind
      end

      it "selects product one time" do
        subject
        expect(selector).to have_received(:perform)
      end
    end

    context "two times input" do
      before do
        prompt.input << "y" << "\n" << "n" << "\n"
        prompt.input.rewind
      end

      it "selects product two times" do
        subject
        expect(selector).to have_received(:perform).exactly(2).times
      end

      it "adds to cart two times" do
        subject
        expect(cart).to have_received(:add).exactly(2).times
      end
    end
  end
end
