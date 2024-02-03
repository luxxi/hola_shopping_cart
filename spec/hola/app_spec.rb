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
      prompt.input << "\n"
      prompt.input.rewind
      subject
      aggregate_failures("verifying output") do
        expect(prompt.output.string).to start_with("Hola. It's shopping time 🛍️\n")
        expect(prompt.output.string).to include("Green Tea (3.11€)")
        expect(prompt.output.string).to include("Strawberries (5.00€)")
        expect(prompt.output.string).to include("Coffee (11.23€)")
      end
    end

    it "selects Strawberries" do
      prompt.input << "j" << "\n" << "j" << "\n"
      prompt.input.rewind
      expect(subject).to eq("Strawberries (5.00€)")
    end
  end
end
