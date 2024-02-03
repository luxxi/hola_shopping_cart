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

    before do
      prompt.on :keypress do |e|
        prompt.trigger :keyup   if e.value == "k"
        prompt.trigger :keydown if e.value == "j"
      end
    end

    it "prints correct output" do
      prompt.input << "\n" << 1 << "\n"
      prompt.input.rewind
      subject
      aggregate_failures("verifying output") do
        expect(prompt.output.string).to start_with("Hola. It's shopping time 🛍️\n")
        expect(prompt.output.string).to include("Green Tea (3.11€)")
        expect(prompt.output.string).to include("Strawberries (5.00€)")
        expect(prompt.output.string).to include("Coffee (11.23€)")
        expect(prompt.output.string).to include(
          "How much quantity would you like to add in cart (stock: 100)?"
        )
      end
    end

    it "selects Strawberries" do
      prompt.input << "j" << "\n" << "j" << "\n" << 1 << "\n"
      prompt.input.rewind
      subject
      aggregate_failures("verifying product selection") do
        expect(prompt.output.string).to include(
          "Please choose product \e[32mStrawberries (5.00€)"
        )
        expect(prompt.output.string).not_to include("
          Please choose product \e[32mGreen Tea (3.11€)"
        )
        expect(prompt.output.string).not_to include("
          Please choose product \e[32mCoffee (11.23€)"
        )
      end
    end

    it "selects quantity" do
      prompt.input << "\n" << 3 << "\n"
      prompt.input.rewind
      subject
      expect(prompt.output.string).to include(
        "How much quantity would you like to add in cart (stock: 100)?  3"
      )
    end
  end
end
