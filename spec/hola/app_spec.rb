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

    let(:selector) { instance_double(Hola::Helper::ProductSelector) }
    before do
      allow(Hola::Helper::ProductSelector).to receive(:new).and_return(selector)
      allow(selector).to receive(:perform).and_return({
        product: "Green Tea (3.11€)",
        quantity: 2
      })
    end

    it "selects input one time" do
      prompt.input << "n" << "\n"
      prompt.input.rewind
      subject
      expect(selector).to have_received(:perform)
    end

    it "selects input two times" do
      prompt.input << "y" << "\n" << "n" << "\n"
      prompt.input.rewind
      subject
      expect(selector).to have_received(:perform).exactly(2).times
    end
  end
end
