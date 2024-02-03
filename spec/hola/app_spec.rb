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

    it "prints welcome text" do
      subject
      expect(prompt.output.string).to start_with("Hola. It's shopping time 🛍️\n")
    end
  end
end
